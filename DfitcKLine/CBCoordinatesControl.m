//
//  CBCoordinatesControl.m
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/11.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import "CBCoordinatesControl.h"
#import "CBKLineConstant.h"

@implementation CBCoordinatesControl

+(void)cbDrawYCoordinatesWithPrice:(NSMutableArray*)yPrice
                           Percent:(NSMutableArray*)yPercent
                           Context:(CGContextRef)context
                            InView:(UIView*)view{

    //坐标轴及参考线
    CGContextSetLineWidth(context, HYStockChartTimeLineLineWidth);
    
    CGFloat height = view.frame.size.height;
    for (int i = 0; i<5; i++) {
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);

        CGContextMoveToPoint(context, 0, i*height/4.0);
        CGContextAddLineToPoint(context, view.frame.size.width, i*height/4.0);
        CGContextStrokePath(context);
        [self drawAtPoint:CGPointMake(0, i*height/4.0) withStr:[yPrice objectAtIndex:i]];
    }
    
    //左侧价格
    
    //右侧涨跌幅
    
}
+(void)drawAtPoint:(CGPoint)point withStr:(NSString *)str
{
    [str drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9], NSStrokeColorAttributeName:[UIColor orangeColor]}];
}

@end
