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
@interface CBKChartViewItemModel : NSObject

@property(nonatomic,copy) NSString *title;
@property(nonatomic,assign) CBKChartViewType centerViewType;
+(instancetype)itemModelWithTitle:(NSString *)title type:(CBKChartViewType)type;

@end


@protocol CBKChartViewDataSource;

@interface CBContainerView : UIView

@property(nonatomic,strong) NSArray *itemModels;

/**
 *  数据源
 */
@property(nonatomic,weak) id<CBKChartViewDataSource> dataSource;

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
@protocol CBKChartViewDataSource <NSObject>

@required
/**
 *  某个index指定的数据
 */
-(id)stockDatasWithIndex:(NSInteger)index;

@end
