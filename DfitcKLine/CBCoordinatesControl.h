//
//  CBCoordinatesControl.h
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/11.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 绘制坐标轴、参考线、坐标单位*/

//找出最大涨跌幅及对应的价格，以首个价格为中心点在Y轴上对称显示
//绘制坐标轴及横向纵向参考线
//

@interface CBCoordinatesControl : NSObject

//top view 的Y坐标轴、参考线、价格和涨跌幅
+(void)cbDrawYCoordinatesWithPrice:(NSMutableArray*)yPrice
                           Percent:(NSMutableArray*)yPercent
                           Context:(CGContextRef)context
                            InView:(UIView*)view;



@end
