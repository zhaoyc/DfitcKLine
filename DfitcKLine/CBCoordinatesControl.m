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

+(void)cbDrawVLinesContext:(CGContextRef)context InView:(UIView*)view{

    CGContextSetLineWidth(context, HYStockChartTimeLineLineWidth);
    CGFloat width = view.frame.size.width;
    CGFloat height = view.frame.size.height;
    
    for (int i = 0; i < 4; i ++) {
        CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
        CGContextMoveToPoint(context, i*width/4.0, 0);
        CGContextAddLineToPoint(context, i*width/4.0, height);
        CGContextStrokePath(context);
    }
}
#pragma mark - top view
+(void)cbDrawYCoordinatesWithPrice:(NSMutableArray*)yPrice
                           Percent:(NSMutableArray*)yPercent
                           Context:(CGContextRef)context
                            InView:(UIView*)view{

    //坐标轴及参考线
    CGContextSetLineWidth(context, HYStockChartTimeLineLineWidth);

    CGFloat height = view.frame.size.height;
    for (int i = 0; i<5; i++) {

//        const CGFloat lengths[] = {1,3};
//        CGContextSetLineDash(context, 0, lengths, 2);
        CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
        CGContextMoveToPoint(context, 0, i*height/4.0);
        CGContextAddLineToPoint(context, view.frame.size.width, i*height/4.0);
        CGContextStrokePath(context);
        
        [self drawPriceAtPoint:CGPointMake(5, i*height/4.0) withStr:[yPrice objectAtIndex:i] index:i];
        [self drawPriceAtPoint:CGPointMake(view.frame.size.width-35, i*height/4.0) withStr:[yPercent objectAtIndex:i] index:i];
        
    }
        
}

+(void)drawPriceAtPoint:(CGPoint)point withStr:(NSString *)str index:(NSInteger)i
{
    CGPoint pp = CGPointMake(point.x, point.y-5);
    UIColor *color;
    
    switch (i) {
        case 0:{
            pp = CGPointMake(point.x, point.y);
            color = [UIColor redColor];
        }
            break;
        case 1:
            color = [UIColor redColor];

            break;
        case 2:
            color = [UIColor whiteColor];

            break;
        case 3:
            color = [UIColor greenColor];

            break;
        case 4:{
            pp = CGPointMake(point.x, point.y-10);
            color = [UIColor greenColor];

        }

            break;
            
        default:
            break;
    }

    [str drawAtPoint:pp withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9], NSForegroundColorAttributeName:color}];
}

#pragma mark - bottom view
+(void)cbDrawBottomViewWithArr:(NSMutableArray*)arr
                       Context:(CGContextRef)context
                        InView:(UIView*)view
{
    CGContextSetLineWidth(context, HYStockChartTimeLineLineWidth);
    CGFloat height = view.frame.size.height -20;
    
    for (int i = 0; i < [arr count]+1; i ++) {
        CGPoint point = CGPointMake(0, i*height/2.0+20);
        
        CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
        CGContextMoveToPoint(context, 0, point.y);
        CGContextAddLineToPoint(context, view.frame.size.width, point.y);
        CGContextStrokePath(context);

        if (i < 2) {
            NSMutableDictionary *dic = [arr objectAtIndex:i];

            [self drawCountAtPoint:CGPointMake(5, point.y) withStr:[dic objectForKey:@"LEFT"] isLeft:YES];
            [self drawCountAtPoint:CGPointMake(view.frame.size.width-30, point.y) withStr:[dic objectForKey:@"RIGHT"] isLeft:NO];
        }
    }
}

+(void)drawCountAtPoint:(CGPoint)point withStr:(NSString *)str isLeft:(BOOL)left
{

    CGPoint pp = point;
    
    UIColor *color = [UIColor whiteColor];
    if (left) {
        color = [UIColor yellowColor];
    }else
    {
    
    }
    [str drawAtPoint:pp withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9], NSForegroundColorAttributeName:color}];

}

@end
