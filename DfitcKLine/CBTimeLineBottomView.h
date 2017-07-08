//
//  CBTimeLineBottomView.h
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/8.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBTimeLineModel;

@interface CBTimeLineBottomView : UIView

@property(nonatomic,strong) NSArray *timeLineModels;

@property(nonatomic,strong) NSArray *xPositionArray;

/**
 *  画下面的view
 */
-(void)drawBelowView;

/**
 *  根据指定颜色清除背景
 */
-(void)clearRectWithColor:(UIColor *)bgColor NS_DEPRECATED_IOS(2_0,2_0,"这个方法暂时没有实现!");

@end
