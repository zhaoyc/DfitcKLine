//
//  CBTimeLineTopView.m
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/8.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import "CBTimeLineTopView.h"
#import "CBTimeLineModel.h"
#import "CBKLineConstant.h"
#import "CBTimeLineTopPositionModel.h"
#import "CBTimeLine.h"
#import "CBTimeLineModelGroup.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "CBCoordinatesControl.h"

@interface CBTimeLineTopView ()

@property(nonatomic,strong) NSArray *positionModels;

@property(nonatomic,assign) CGFloat horizontalViewYPosition;

@property(nonatomic,strong) UIView *timeLabelView;

@property(nonatomic,strong) NSArray *timeLineModels;

@property(nonatomic,strong) UILabel *firstTimeLabel;

@property(nonatomic,strong) UILabel *secondTimeLabel;

@property(nonatomic,strong) UILabel *thirdTimeLabel;

@property(nonatomic,strong) NSMutableArray *yPriceArr;

@property(nonatomic,strong) NSMutableArray *yPercentArr;

@property(nonatomic,strong) NSMutableArray *yPositionArr;

@end


@implementation CBTimeLineTopView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _positionModels = nil;
        _horizontalViewYPosition = 0;
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    if (!self.timeLineModels) {
        return;
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextClearRect(context, rect);
//    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
//    CGContextFillRect(context, rect);
    
    CBTimeLine *timeLine = [[CBTimeLine alloc] initWithContext:context];
    timeLine.positionModels = [self private_convertTimeLineModlesToPositionModel];
    timeLine.horizontalYPosition = self.horizontalViewYPosition;
    timeLine.timeLineViewWidth = self.frame.size.width;
    [timeLine draw];

    [super drawRect:rect];
}

#pragma mark - setter and getter

-(void)setGroupModel:(CBTimeLineModelGroup *)groupModel
{
    _groupModel = groupModel;
    
    if (groupModel) {
        
        //先将groupModel里面的数组根据时间排序
        NSArray *timeLineModels = groupModel.timeModels;
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MM-dd-yyyy";
        NSDateFormatter *timeFormatter = [NSDateFormatter new];
        timeFormatter.dateFormat = @"hh:mm:ss a";
        NSArray *newTimeLineModels = [timeLineModels sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            CBTimeLineModel *timeLineModel1 = (CBTimeLineModel *)obj1;
            CBTimeLineModel *timeLineModel2 = (CBTimeLineModel *)obj2;
            NSDate *date1 = [dateFormatter dateFromString:timeLineModel1.currentDate];
            NSDate *date2 = [dateFormatter dateFromString:timeLineModel2.currentDate];
            if ([date1 compare:date2] != NSOrderedSame) {
                return [date1 compare:date2];
            }else{
                date1 = [timeFormatter dateFromString:timeLineModel1.currentTime];
                date2 = [timeFormatter dateFromString:timeLineModel2.currentTime];
                return [date1 compare:date2];
            }
            return YES;
        }];
        
        self.timeLineModels = newTimeLineModels;
        _groupModel.timeModels = newTimeLineModels;
        self.timeLabelView.backgroundColor = [UIColor clearColor];
    }
}
#pragma mark - public

-(void)drawAboveView
{
    NSAssert(self.timeLineModels, @"timeLineModels不能为空!");
    [self setNeedsDisplay];
}

-(CGFloat)getRightXPositionWithOriginXPosition:(CGFloat)originXPosition
{
    NSAssert(_positionModels, @"位置数组不能为空!");
    CGFloat gap = 0.6;
    if (self.positionModels.count > 1) {
        CBTimeLineTopPositionModel *firstModel = [self.positionModels firstObject];
        CBTimeLineTopPositionModel *secondModel = self.positionModels[1];
        gap = (secondModel.currentPoint.x - firstModel.currentPoint.x)/2;
    }
    NSInteger idx = 0;
    for (CBTimeLineTopPositionModel *positionModel in self.positionModels) {
        if (originXPosition < positionModel.currentPoint.x+gap && originXPosition > positionModel.currentPoint.x-gap) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(timeLineAboveViewLongPressTimeLineModel:)]) {
                [self.delegate timeLineAboveViewLongPressTimeLineModel:self.timeLineModels[idx]];
            }
            return positionModel.currentPoint.x;
        }
        idx++;
    }
    //这里必须为负数，没有找到的合适的位置，竖线就返回这个位置。
    return -10;
}

#pragma mark - private
//将Model转换成对应的position模型
-(NSArray *)private_convertTimeLineModlesToPositionModel
{
    NSAssert(self.timeLineModels, @"timeLineModels不能为空!");
    //1.算y轴的单元值
    CBTimeLineModel *firstModel = [self.timeLineModels firstObject];
    __block CGFloat minPrice = firstModel.currentPrice;
    __block CGFloat maxPrice = firstModel.currentPrice;
    __block CGFloat centerPointPrice = firstModel.currentPrice;
    
    [self.timeLineModels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CBTimeLineModel *timeLineModel = (CBTimeLineModel *)obj;
        if (timeLineModel.currentPrice < minPrice) {
            minPrice = timeLineModel.currentPrice;
        }
        if (timeLineModel.currentPrice > maxPrice) {
            maxPrice = timeLineModel.currentPrice;
        }
    }];
    CGFloat minY = HYStockChartTimeLineAboveViewMinY;
    CGFloat maxY = HYStockChartTimeLineAboveViewMaxY;
    
    CGFloat yUnitValue;
    CGFloat yMaxPriceRange;
    if (fabs(centerPointPrice-maxPrice)>fabs(centerPointPrice-minPrice)) {
        
        yMaxPriceRange = fabs(centerPointPrice-maxPrice)*2;
        yUnitValue = yMaxPriceRange/(maxY-minY);
        [self yPriceArrWithBasePrice:centerPointPrice maxPrice:maxPrice rise:YES];
        
    }else{
        yMaxPriceRange = fabs(centerPointPrice-minPrice)*2;
        yUnitValue = yMaxPriceRange/(maxY-minY);
        [self yPriceArrWithBasePrice:centerPointPrice maxPrice:minPrice rise:NO];
    }
    
    [CBCoordinatesControl cbDrawYCoordinatesWithPrice:self.yPriceArr Percent:self.yPercentArr Context:UIGraphicsGetCurrentContext() InView:self];
    
    self.horizontalViewYPosition = maxY/2.0;
    NSLog(@"self.timeLineModels.count = %lu",(unsigned long)[self.timeLineModels count]);
    //2.算出x轴的单元值
    CGFloat xUnitValue = [self private_getXAxisUnitValue];
    
    NSMutableArray *positionArray = [NSMutableArray array];
    NSInteger index = 0;
    
    CGFloat oldXPosition = -1;
    for (CBTimeLineModel *timeLineModel in self.timeLineModels) {
        CGFloat xPosition = 0;
        CGFloat yPosition = 0;
        switch (self.centerViewType) {
            case HYStockChartCenterViewTypeTimeLine:
            {
                if (oldXPosition < 0) {
                    oldXPosition = 0;
                    xPosition = oldXPosition;
                }else{
                    //每2分钟一次数据
                    xPosition = oldXPosition+2*xUnitValue;
                    oldXPosition = xPosition;
                }
                yPosition = (maxY - (timeLineModel.currentPrice - minPrice)/yUnitValue);
                yPosition = maxY - (timeLineModel.currentPrice - (centerPointPrice-yMaxPriceRange/2.0))/yUnitValue;
            }
                break;
            default:
                break;
        }
        index++;
        NSAssert(!isnan(xPosition)&&!isnan(yPosition), @"x或y出现NAN值!");
        CBTimeLineTopPositionModel *positionModel = [CBTimeLineTopPositionModel new];
        positionModel.currentPoint = CGPointMake(xPosition, yPosition);
        [positionArray addObject:positionModel];
    }
    _positionModels = positionArray;
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(timeLineAboveView:positionModels:)]) {
            [self.delegate timeLineAboveView:self positionModels:positionArray];
        }
    }
    return positionArray;
}

-(UILabel *)private_createTimeLabel
{
    UILabel *timeLabel = [UILabel new];
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.textColor = [UIColor whiteColor];
    return timeLabel;
}

-(CGFloat)private_getXAxisUnitValue
{
    NSTimeInterval oneDayTradeTimes = [self private_oneDayTradeTimes];
    CGFloat xUnitValue = 0;
    if (self.centerViewType == HYStockChartCenterViewTypeTimeLine) {
        xUnitValue = (HYStockChartTimeLineAboveViewMaxX-HYStockChartTimeLineAboveViewMinX)/oneDayTradeTimes;
        return xUnitValue;
    }else{
        CBTimeLineModel *currentModel = [self.timeLineModels firstObject];
        NSInteger days = 1;
        for (CBTimeLineModel *timeLineModel in self.timeLineModels) {
            if (![currentModel.currentDate isEqualToString:timeLineModel.currentDate]) {
                currentModel = timeLineModel;
                days += 1;
            }
        }
        NSTimeInterval totalMinutes = days * oneDayTradeTimes;
        xUnitValue = (HYStockChartTimeLineAboveViewMaxX-HYStockChartTimeLineAboveViewMinX)/totalMinutes;
        
        return xUnitValue;
    }
}

-(CGFloat)private_oneDayTradeTimes
{
    return 240;
}

-(void)yPriceArrWithBasePrice:(CGFloat)baseP maxPrice:(CGFloat)maxP rise:(BOOL)rise{

    self.yPriceArr = [NSMutableArray new];
    self.yPercentArr = [NSMutableArray new];
    
    //y最大偏移量是涨还是跌
    if (rise) {
        [self.yPriceArr addObject:[NSString stringWithFormat:@"%.f",maxP]];
        [self.yPriceArr addObject:[NSString stringWithFormat:@"%.f",baseP + (maxP - baseP)/2.0]];
        [self.yPriceArr addObject:[NSString stringWithFormat:@"%.f",baseP]];
        [self.yPriceArr addObject:[NSString stringWithFormat:@"%.f",baseP - (maxP - baseP)/2.0]];
        [self.yPriceArr addObject:[NSString stringWithFormat:@"%.f",baseP - maxP +baseP]];
        
        [self.yPercentArr addObject:[NSString stringWithFormat:@"+%.2f%%",(maxP-baseP)/baseP]];
        [self.yPercentArr addObject:[NSString stringWithFormat:@"+%.2f%%",(maxP-baseP)/baseP/2.0]];
        [self.yPercentArr addObject:[NSString stringWithFormat:@"0.00%%"]];
        [self.yPercentArr addObject:[NSString stringWithFormat:@"-%.2f%%",(maxP-baseP)/baseP/2.0]];
        [self.yPercentArr addObject:[NSString stringWithFormat:@"-%.2f%%",(maxP-baseP)/baseP]];

    }else{
    
        [self.yPriceArr addObject:[NSString stringWithFormat:@"%.f",maxP]];
        [self.yPriceArr insertObject:[NSString stringWithFormat:@"%.f",baseP + (maxP - baseP)/2.0] atIndex:0];
        [self.yPriceArr insertObject:[NSString stringWithFormat:@"%.f",baseP] atIndex:0];
        [self.yPriceArr insertObject:[NSString stringWithFormat:@"%.f",baseP - (maxP - baseP)/2.0] atIndex:0];
        [self.yPriceArr insertObject:[NSString stringWithFormat:@"%.f",baseP - (maxP - baseP)] atIndex:0];
        
        [self.yPercentArr addObject:[NSString stringWithFormat:@"+%.2f%%",(baseP-maxP)/baseP]];
        [self.yPercentArr addObject:[NSString stringWithFormat:@"+%.2f%%",(baseP-maxP)/baseP/2.0]];
        [self.yPercentArr addObject:[NSString stringWithFormat:@"0.00%%"]];
        [self.yPercentArr addObject:[NSString stringWithFormat:@"-%.2f%%",(baseP-maxP)/baseP/2.0]];
        [self.yPercentArr addObject:[NSString stringWithFormat:@"-%.2f%%",(baseP-maxP)/baseP]];
    }
}

-(void)drawAtPoint:(CGPoint)point withStr:(NSString *)str
{
    [str drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9], NSStrokeColorAttributeName:[UIColor orangeColor]}];
}

@end
