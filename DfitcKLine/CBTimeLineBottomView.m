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
#import "Masonry.h"
#import "CBCoordinatesControl.h"

@interface CBTimeLineBottomView ()

@property(nonatomic,strong) NSArray *positionModels;

@property(nonatomic,strong) NSMutableArray* countArr;

@end


@implementation CBTimeLineBottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _positionModels = nil;
        self.countArr = [NSMutableArray new];
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"2.98万 CJL",@"LEFT",@"4566",@"RIGHT", nil];
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1.78万",@"LEFT",@"4524",@"RIGHT", nil];
        [self.countArr addObject:dic1];
        [self.countArr addObject:dic2];

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
    
    [CBCoordinatesControl cbDrawBottomViewWithArr:self.countArr Context:UIGraphicsGetCurrentContext() InView:self];
    [CBCoordinatesControl cbDrawVLinesContext:UIGraphicsGetCurrentContext() InView:self];
}

-(void)drawBelowView
{
    [self private_convertTimeLineModelsPositionModels];
    NSAssert(self.positionModels, @"positionModels不能为空");
    [self setNeedsDisplay];
}

#pragma mark - private method

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
    CGFloat yUnitValue = (maxVolume - minVolume)/(maxY-20-minY);
    
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
