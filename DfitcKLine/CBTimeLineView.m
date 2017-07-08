//
//  CBTimeLineView.m
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/8.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import "CBTimeLineView.h"
#import "Masonry.h"
#import "CBKLineConstant.h"
#import "CBTimeLineTopView.h"
#import "CBTimeLineBottomView.h"
#import "CBTimeLineTopPositionModel.h"
#import "CBLongPressView.h"


@interface CBTimeLineView()<HYTimeLineAboveViewDelegate>

@property(nonatomic,strong) CBTimeLineTopView *aboveView;

@property(nonatomic,strong) CBTimeLineBottomView *belowView;

@property(nonatomic,strong) UIView *timeLineContainerView;

@property(nonatomic,strong) NSArray *timeLineModels;

@property(nonatomic,strong) UIView *verticalView;

@property(nonatomic,strong) CBLongPressView *timeLineLongPressProfileView;


@end


@implementation CBTimeLineView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.aboveViewRatio = 0.7;
        self.belowView.backgroundColor = [UIColor blackColor];
    }
    return self;
}

#pragma mark set&get方法
#pragma mark aboveView的get方法
-(CBTimeLineTopView *)aboveView
{
    if (!_aboveView) {
        _aboveView = [CBTimeLineTopView new];
        _aboveView.delegate = self;
        [self.timeLineContainerView addSubview:_aboveView];
        [_aboveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.timeLineContainerView);
            make.height.equalTo(self.timeLineContainerView).multipliedBy(self.aboveViewRatio);
        }];
    }
    return _aboveView;
}

#pragma mark belowView的get方法
-(CBTimeLineBottomView *)belowView
{
    if (!_belowView) {
        _belowView = [CBTimeLineBottomView new];
        [self.timeLineContainerView addSubview:_belowView];
        [_belowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.aboveView.mas_bottom);
            make.left.right.equalTo(self.timeLineContainerView);
            make.height.equalTo(self.timeLineContainerView).multipliedBy(1-self.aboveViewRatio);
        }];
    }
    return _belowView;
}

#pragma mark timeLineContainerView的get方法
-(UIView *)timeLineContainerView
{
    if (!_timeLineContainerView) {
        _timeLineContainerView = [UIView new];
        [self addAllEvent];
        [self addSubview:_timeLineContainerView];
        [_timeLineContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.right.equalTo(self);
            make.height.equalTo(self);
        }];
    }
    return _timeLineContainerView;
}


-(CBLongPressView *)timeLineLongPressProfileView
{
    if (!_timeLineLongPressProfileView) {
        _timeLineLongPressProfileView = [CBLongPressView timeLineLongPressProfileView];
        [self addSubview:_timeLineLongPressProfileView];
        [_timeLineLongPressProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_top);
            make.left.right.equalTo(self);
            make.height.equalTo(@(HYStockChartProfileViewHeight));
        }];
    }
    return _timeLineLongPressProfileView;
}

#pragma mark - 模型设置方法
#pragma mark aboveViewRatio设置方法
-(void)setAboveViewRatio:(CGFloat)aboveViewRatio
{
    _aboveViewRatio = aboveViewRatio;
    [_aboveView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self).multipliedBy(_aboveViewRatio);
    }];
    [_belowView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self).multipliedBy(1-_aboveViewRatio);
    }];
}

#pragma mark timeLineModels的设置方法
-(void)setTimeLineGroupModel:(CBTimeLineModelGroup *)timeLineGroupModel
{
    _timeLineGroupModel = timeLineGroupModel;
    if (timeLineGroupModel) {
        self.timeLineModels = timeLineGroupModel.timeModels;
        self.aboveView.groupModel = timeLineGroupModel;
        self.belowView.timeLineModels = self.timeLineModels;
        [self.aboveView drawAboveView];
    }
}

-(void)setCenterViewType:(HYStockChartCenterViewType)centerViewType
{
    _centerViewType = centerViewType;
    self.aboveView.centerViewType = centerViewType;
}

#pragma mark - 私有方法
-(void)addAllEvent
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(event_longPressMethod:)];
    [self.timeLineContainerView addGestureRecognizer:longPress];
}

#pragma mark - 公共方法
#pragma mark 重绘
-(void)reDraw
{
    [self.aboveView drawAboveView];
}

#pragma mark - Event执行方法
#pragma mark 长按执行方法
-(void)event_longPressMethod:(UILongPressGestureRecognizer *)longPress
{
    CGPoint pressPosition = [longPress locationInView:self.aboveView];
    if (UIGestureRecognizerStateBegan == longPress.state || UIGestureRecognizerStateChanged == longPress.state) {
        if (!self.verticalView) {
            self.verticalView = [UIView new];
            self.verticalView.clipsToBounds = YES;
            [self.timeLineContainerView addSubview:self.verticalView];
            self.verticalView.backgroundColor = [UIColor whiteColor];
            [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.width.equalTo(@(HYStockChartLongPressVerticalViewWidth));
                make.height.equalTo(self.mas_height);
                make.left.equalTo(@-10);
            }];
        }
        //改变竖线的位置
        CGFloat xPosition = [self.aboveView getRightXPositionWithOriginXPosition:pressPosition.x];
        [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(xPosition));
        }];
        [self.verticalView layoutIfNeeded];
        self.verticalView.hidden = NO;
    }else{
        if (self.verticalView) {
            self.verticalView.hidden = YES;
        }
        self.timeLineLongPressProfileView.hidden = YES;
    }
}

#pragma mark - HYTimeLineAboveViewDelegate代理方法
-(void)timeLineAboveView:(UIView *)timeLineAboveView positionModels:(NSArray *)positionModels
{
    NSMutableArray *xPositionArr = [NSMutableArray array];
    for (CBTimeLineTopPositionModel *positionModel in positionModels) {
        [xPositionArr addObject:[NSNumber numberWithFloat:positionModel.currentPoint.x]];
    }
    self.belowView.xPositionArray = xPositionArr;
    [self.belowView drawBelowView];
}

-(void)timeLineAboveViewLongPressTimeLineModel:(CBTimeLineModel *)timeLineModel
{
    if (self.centerViewType == HYStockChartCenterViewTypeTimeLine) {
        self.timeLineLongPressProfileView.timeLineModel = timeLineModel;
        self.timeLineLongPressProfileView.hidden = NO;
    }else{

    }
}

@end
