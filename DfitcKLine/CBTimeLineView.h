//
//  CBTimeLineView.h
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/8.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBTimeLineModelGroup.h"
#import "CBKLineConstant.h"

@interface CBTimeLineView : UIView

@property(nonatomic,strong) CBTimeLineModelGroup *timeLineGroupModel;

@property(nonatomic,assign) CGFloat aboveViewRatio;

@property(nonatomic,assign) BOOL isNeedDrawTime;

@property(nonatomic,assign) HYStockChartCenterViewType centerViewType;

/**
 *  重绘
 */
-(void)reDraw;

/**
 *  根据指定颜色清除背景
 */
-(void)clearRectWithColor:(UIColor *)bgColor NS_DEPRECATED_IOS(2_0,2_0,"这个方法暂时没有实现!");

@end
