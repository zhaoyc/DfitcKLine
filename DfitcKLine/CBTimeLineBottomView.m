//
//  CBTimeLineBottomView.m
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/8.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import "CBTimeLineBottomView.h"
#import "CBKLineConstant.h"
#import "CBTimeLineModel.h"
#import "CBTimeLineBottomPositionModel.h"
#import "CBTimeLineBottomVolum.h"

@interface CBTimeLineBottomView ()

@property(nonatomic,strong) NSArray *positionModels;

@end


@implementation CBTimeLineBottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _positionModels = nil;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (!self.positionModels) {
        return;
    }
    CBTimeLineBottomVolum *timeLineVolumn = [[CBTimeLineBottomVolum alloc] initWithContext:UIGraphicsGetCurrentContext()];
    timeLineVolumn.timeLineVolumnPositionModels = self.positionModels;
    [timeLineVolumn draw];
}


#pragma mark - 时间
-(void)drawBelowView
{
    [self private_convertTimeLineModelsPositionModels];
    NSAssert(self.positionModels, @"positionModels不能为空");
    [self setNeedsDisplay];
}

#pragma mark - 私有方法
#pragma mark 将分时线的模型数组转换成Y坐标的
-(NSArray *)private_convertTimeLineModelsPositionModels
{
    NSAssert(self.timeLineModels && self.xPositionArray && self.timeLineModels.count == self.xPositionArray.count, @"timeLineModels不能为空!");
    //1.算y轴的单元值
    CBTimeLineModel *firstModel = [self.timeLineModels firstObject];
    __block CGFloat minVolume = firstModel.volume;
    __block CGFloat maxVolume = firstModel.volume;
    [self.timeLineModels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CBTimeLineModel *timeLineModel = (CBTimeLineModel *)obj;
        if (timeLineModel.volume < minVolume) {
            minVolume = timeLineModel.volume;
        }
        if (timeLineModel.volume > maxVolume) {
            maxVolume = timeLineModel.volume;
        }
        if (timeLineModel.volume < 0) {
            NSLog(@"%ld",timeLineModel.volume);
        }
    }];
    CGFloat minY = HYStockChartTimeLineBelowViewMinY;
    CGFloat maxY = HYStockChartTimeLineBelowViewMaxY;
    CGFloat yUnitValue = (maxVolume - minVolume)/(maxY-minY);
    
    NSMutableArray *positionArray = [NSMutableArray array];
    
    NSInteger index = 0;
    for (CBTimeLineModel *timeLineModel in self.timeLineModels) {
        CGFloat xPosition = [self.xPositionArray[index] floatValue];
        CGFloat yPosition = (maxY - (timeLineModel.volume - minVolume)/yUnitValue);
        CBTimeLineBottomPositionModel *positionModel = [CBTimeLineBottomPositionModel new];
        positionModel.startPoint = CGPointMake(xPosition, maxY);
        positionModel.endPoint = CGPointMake(xPosition, yPosition);
        [positionArray addObject:positionModel];
        index++;
    }
    _positionModels = positionArray;
    return positionArray;
}


@end
