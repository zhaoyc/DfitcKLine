//
//  CBTimeLineTopView.h
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/8.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBKLineConstant.h"

@class CBTimeLineModelGroup;
@protocol HYTimeLineAboveViewDelegate;
@class CBTimeLineModel;

/************************分时线上面的view************************/
@interface  CBTimeLineTopView: UIView

/**
 *  分时线的模型
 */
@property(nonatomic,strong) CBTimeLineModelGroup *groupModel;

@property(nonatomic,assign) CBKChartViewType centerViewType;

@property(nonatomic,weak) id<HYTimeLineAboveViewDelegate> delegate;

/**
 *  画AboveView
 */
-(void)drawAboveView;

/**
 *  根据指定颜色清除背景
 */
-(void)clearRectWithColor:(UIColor *)bgColor NS_DEPRECATED_IOS(2_0,2_0,"这个方法暂时没有实现!");

/**
 *  长按的时候根据原始的x的位置获得精确的X的位置
 */
-(CGFloat)getRightXPositionWithOriginXPosition:(CGFloat)originXPosition;


@end


@protocol HYTimeLineAboveViewDelegate <NSObject>

@optional
-(void)timeLineAboveView:(UIView *)timeLineAboveView positionModels:(NSArray *)positionModels;

-(void)timeLineAboveViewLongPressTimeLineModel:(CBTimeLineModel *)timeLineModel;
@end
