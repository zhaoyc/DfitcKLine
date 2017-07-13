//
//  CBTimeLineBottomVolum.m
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/8.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import "CBTimeLineBottomVolum.h"
#import "CBTimeLineBottomPositionModel.h"
#import "CBKLineConstant.h"

@interface CBTimeLineBottomVolum ()

@property(nonatomic,assign) CGContextRef context;

@end


@implementation CBTimeLineBottomVolum

-(instancetype)initWithContext:(CGContextRef)context
{
    self = [super init];
    if (self) {
        _context = context;
    }
    return self;
}

-(void)draw
{
    NSAssert(self.timeLineVolumnPositionModels && self.context, @"timeLineVolumnPositionModels不能为空！");
    CGContextRef context = self.context;
    CGContextSetStrokeColorWithColor(self.context, [UIColor yellowColor].CGColor);
    CGContextSetLineWidth(self.context, CBKChartTimeLineVolumeLineWidth);
    for (CBTimeLineBottomPositionModel *positionModel in self.timeLineVolumnPositionModels) {
        //画实体线
        const CGPoint solidPoints[] = {positionModel.startPoint,positionModel.endPoint};
        CGContextStrokeLineSegments(context, solidPoints, 2);
    }
}


@end
