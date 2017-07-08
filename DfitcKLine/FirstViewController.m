//
//  FirstViewController.m
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/5.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import "FirstViewController.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "CBKLine.h"
#import "JMSTimeLineModel.h"
#import "JMSGroupTimeLineModel.h"

@interface FirstViewController ()<HYStockChartViewDataSource>

@property(nonatomic,strong) CBContainerView *containerView;

@property(nonatomic,assign) BOOL isFullScreen;

@property(nonatomic,strong) UIButton *cancelBtn;

@property(nonatomic,strong) JMSGroupTimeLineModel *groupTimeLineModel;

@property(nonatomic,strong) NSArray *fiveDaysModels;    //5日线的模型数组

//@property(nonatomic,strong) JMSKLineGroupModel *dayKLineGroupModel;//日K线groupModel
//
//@property(nonatomic,strong) JMSKLineGroupModel *weekKLineGroupModle;   //周K线的groupModel
//
//@property(nonatomic,strong) JMSKLineGroupModel *monthKLineGroupModle;   //月K线的groupModel

@property(nonatomic,assign) NSInteger dayKlineTotalMonthAgo;

@property(nonatomic,strong) UIButton *refreshBtn;

@property(nonatomic,strong) UIActivityIndicatorView *indicatorView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.containerView.backgroundColor = [UIColor blackColor];
    
}

-(CBContainerView *)containerView
{
    if (!_containerView) {
        _containerView = [CBContainerView new];
        _containerView.itemModels = @[
                                       [HYStockChartViewItemModel itemModelWithTitle:@"分时" type:HYStockChartCenterViewTypeTimeLine],
                                       [HYStockChartViewItemModel itemModelWithTitle:@"1M" type:HYStockChartCenterViewTypeBrokenLine],
                                       [HYStockChartViewItemModel itemModelWithTitle:@"5M" type:HYStockChartCenterViewTypeKLine],
                                       [HYStockChartViewItemModel itemModelWithTitle:@"1H" type:HYStockChartCenterViewTypeKLine],
                                       [HYStockChartViewItemModel itemModelWithTitle:@"1日" type:HYStockChartCenterViewTypeKLine],
                                       ];
        _containerView.dataSource = self;
        [self.view addSubview:self.containerView];
        [self.view bringSubviewToFront:self.indicatorView];
        [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _containerView;
}
#pragma mark indicatorView的get方法
-(UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.view addSubview:_indicatorView];
        [self.view bringSubviewToFront:_indicatorView];
        [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
    }
    return _indicatorView;
}

#pragma mark - set方法
#pragma mark 设置是否需要全屏的方法
-(void)setIsFullScreen:(BOOL)isFullScreen
{
    _isFullScreen = isFullScreen;
    if (isFullScreen) {
        [UIView animateWithDuration:0.5f animations:^{
            [[UIDevice currentDevice] setValue:
             [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            [[UIDevice currentDevice] setValue:
             [NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];
        }];
    }
}

#pragma mark 分时线数据请求方法
-(void)event_timeLineRequestMethod
{
    //加载假分时线数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TimeLine" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *datas = [dict objectForKey:@"Bars"];
    CGFloat PreClose = [[dict objectForKey:@"PreClose"] floatValue];
    if (!self.groupTimeLineModel) {
        self.groupTimeLineModel = [JMSGroupTimeLineModel new];
    }
    self.groupTimeLineModel.timeLineModels = [JMSTimeLineModel objectArrayWithKeyValuesArray:datas];
    self.groupTimeLineModel.lastDayEndPrice = PreClose;
    [self.containerView reloadData];
}

-(id)stockDatasWithIndex:(NSInteger)index
{
    [self.indicatorView startAnimating];
    switch (index) {
        case 0:
            //时分
            if (self.groupTimeLineModel.timeLineModels.count > 0) {
                //先将jms转换成hy
                NSArray *jmsTimeLineDict = [JMSTimeLineModel keyValuesArrayWithObjectArray:self.groupTimeLineModel.timeLineModels];
                NSArray *hyTimeLineModels = [CBTimeLineModel objectArrayWithKeyValuesArray:jmsTimeLineDict];
                CBTimeLineModelGroup *hyTimeGroupModel = [CBTimeLineModelGroup new];
                hyTimeGroupModel.lastDayEndPrice = self.groupTimeLineModel.lastDayEndPrice;
                hyTimeGroupModel.timeModels = hyTimeLineModels;
                [self.indicatorView stopAnimating];
                return hyTimeGroupModel;
            }else{
                [self event_timeLineRequestMethod];
            }
            break;
            
        case 1:
            //5日线

                break;
        case 2:
            //日K线

                break;
        case 3:
            //周K线
            break;
        case 4:
            //月K
            break;
        default:
            break;
    }
    return nil;
}


#pragma mark - 屏幕旋转相关方法
#pragma mark 是否支持自动旋转
-(BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark 支持的方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
