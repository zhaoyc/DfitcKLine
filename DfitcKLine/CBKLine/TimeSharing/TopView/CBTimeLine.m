//
//  CBTimeLine.m
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/6.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import "CBTimeLine.h"
#import "CBKLineConstant.h"

@interface CBTimeLine()

@property(nonatomic,assign) CGContextRef context;

@end

@implementation CBTimeLine

-(instancetype)initWithContext:(CGContextRef)context
{
    self = [super init];
    if (self) {
        self.context = context;
        _horizontalYPosition = -1;
    }
    return self;
}

-(void)draw
{
    NSAssert(self.context && self.positionModels, @"context或者positionModel不能为空!");
    NSInteger count = self.positionModels.count;
    NSArray *positionModels = self.positionModels;
    CGContextSetLineWidth(self.context, CBKChartTimeLineLineWidth);
    CGContextSetStrokeColorWithColor(self.context, [UIColor whiteColor].CGColor);
    for (NSInteger index = 0; index < count; index++) {
        CBTimeLineTopPositionModel *positionModel = (CBTimeLineTopPositionModel *)positionModels[index];
        if (isnan(positionModel.currentPoint.x) || isnan(positionModel.currentPoint.y)) {
            continue;
        }
        NSAssert(!isnan(positionModel.currentPoint.x) && !isnan(positionModel.currentPoint.y) && !isinf(positionModel.currentPoint.x) && !isinf(positionModel.currentPoint.y), @"不符合要求的点！");
        CGContextMoveToPoint(self.context, positionModel.currentPoint.x, positionModel.currentPoint.y);
        if (index+1 < count) {
            CBTimeLineTopPositionModel *nextPositionModel = (CBTimeLineTopPositionModel *)positionModels[index+1];
            CGContextAddLineToPoint(self.context, nextPositionModel.currentPoint.x, nextPositionModel.currentPoint.y);
        }
        CGContextStrokePath(self.context);
    }
}

@end
