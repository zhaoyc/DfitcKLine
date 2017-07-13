//
//  CBContainerView.m
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/6.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import "CBContainerView.h"
#import "Masonry.h"
#import "CBSegmentView.h"
#import "CBTimeLineView.h"
#import "CBTimeLineModel.h"
#import "CBTimeLineModelGroup.h"
#import "CBKLineConstant.h"

@interface CBContainerView ()<HYStockChartViewDelegate>


@property(nonatomic,strong) CBSegmentView *segmentView;

@property(nonatomic,strong) UILabel *companyNameLabel;

@property(nonatomic,strong) CBTimeLineView *timeLineView;   //分时线view

//@property(nonatomic,strong) HYKLineView *kLineView;         //K线view

@property(nonatomic,assign) CBKChartViewType currentCenterViewType;

@property(nonatomic,assign,readwrite) NSInteger currentIndex;

@end

@implementation CBContainerView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark - getters

-(CBSegmentView *)segmentView
{
    if (!_segmentView) {
        _segmentView = [[CBSegmentView alloc] init];
        _segmentView.delegate = self;
        [self addSubview:_segmentView];
        [_segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@64);
            make.width.equalTo(self);
            make.height.equalTo(@35);
        }];
    }
    return _segmentView;
}

-(CBTimeLineView *)timeLineView
{
    if (!_timeLineView) {
        _timeLineView = [CBTimeLineView new];
        _timeLineView.centerViewType = CBKChartViewTypeTimeLine;
        [self addSubview:_timeLineView];
        [_timeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.top.equalTo(self.segmentView.mas_bottom);
            make.height.equalTo(self).multipliedBy(0.5);
        }];
    }
    return _timeLineView;
}

-(void)setItemModels:(NSArray *)itemModels
{
    _itemModels = itemModels;
    if (itemModels) {
        NSMutableArray *items = [NSMutableArray array];
        for (CBKChartViewItemModel *item in itemModels) {
            [items addObject:item.title];
        }
        self.segmentView.items = items;
        CBKChartViewItemModel *firstModel = [itemModels firstObject];
        self.currentCenterViewType = firstModel.centerViewType;
    }
    if (self.dataSource) {
        self.segmentView.selectedIndex = 0;
    }
}

-(void)setDataSource:(id<CBKChartViewDataSource>)dataSource
{
    _dataSource = dataSource;
    if (self.itemModels) {
        self.segmentView.selectedIndex = 0;
    }
}

-(void)reloadData
{
    self.segmentView.selectedIndex = self.segmentView.selectedIndex;
}

-(void)cBKLineSegmentSelectedAtIndex:(NSUInteger)selectedIndex{

    self.currentIndex = selectedIndex;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(stockDatasWithIndex:)]) {
        id stockData = [self.dataSource stockDatasWithIndex:selectedIndex];
        
        if (!stockData) {
            return;
        }
        
        CBKChartViewItemModel *itemModel = self.itemModels[selectedIndex];
        CBKChartViewType type = itemModel.centerViewType;
        if (type != self.currentCenterViewType) {
            //移除原来的view，设置新的view
            self.currentCenterViewType = type;
            if (type == CBKChartViewTypeKLine) {
//                self.kLineView.hidden = NO;
                self.timeLineView.hidden = YES;
//                [self bringSubviewToFront:self.kLineView];
            }else if(CBKChartViewTypeTimeLine == type){
                self.timeLineView.hidden = NO;
//                self.kLineView.hidden = YES;
            }
        }
        
        if (type == CBKChartViewTypeTimeLine) {
            NSAssert([stockData isKindOfClass:[CBTimeLineModelGroup class]], @"数据必须是CBTimeLineModelGroup类型!!!");
            CBTimeLineModelGroup *groupTimeLineModel = (CBTimeLineModelGroup *)stockData;
            if (type == CBKChartViewTypeTimeLine) {
                self.timeLineView.timeLineGroupModel = groupTimeLineModel;
                [self.timeLineView reDraw];
            }else{

            }
        }else{
//            NSArray *stockDataArray = (NSArray *)stockData;
//            self.kLineView.kLineModels = stockDataArray;
//            [self.kLineView reDraw];
        }
    }

}
@end


/************************ItemModel类************************/
@implementation CBKChartViewItemModel
+(instancetype)itemModelWithTitle:(NSString *)title type:(CBKChartViewType)type
{
    CBKChartViewItemModel *itemModel = [[CBKChartViewItemModel alloc] init];
    itemModel.title = title;
    itemModel.centerViewType = type;
    return itemModel;
}
@end
