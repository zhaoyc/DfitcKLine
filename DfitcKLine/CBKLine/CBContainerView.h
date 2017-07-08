//
//  CBContainerView.h
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/6.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBKLineConstant.h"

/************************ItemModel类************************/
@interface HYStockChartViewItemModel : NSObject

@property(nonatomic,copy) NSString *title;
@property(nonatomic,assign) HYStockChartCenterViewType centerViewType;
+(instancetype)itemModelWithTitle:(NSString *)title type:(HYStockChartCenterViewType)type;

@end


@protocol HYStockChartViewDataSource;

@interface CBContainerView : UIView

@property(nonatomic,strong) NSArray *itemModels;

/**
 *  数据源
 */
@property(nonatomic,weak) id<HYStockChartViewDataSource> dataSource;

/**
 *  选中的索引
 */
@property(nonatomic,assign,readonly) NSInteger currentIndex;

/**
 *  重新加载数据
 */
-(void)reloadData;


@end



/************************代理************************/
@protocol HYStockChartViewDelegate <NSObject>
@end

/************************数据源************************/
@protocol HYStockChartViewDataSource <NSObject>

@required
/**
 *  某个index指定的数据
 */
-(id)stockDatasWithIndex:(NSInteger)index;

@end
