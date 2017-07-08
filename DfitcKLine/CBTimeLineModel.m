//
//  CBTimeLineModel.m
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/6.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import "CBTimeLineModel.h"
#import "MJExtension.h"

@implementation CBTimeLineModel
+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"currentPrice":@"Close",
             @"currentTime":@"EndTime",
             @"currentDate":@"EndDate",
             @"volume":@"Volume"
             };
}

-(NSString *)currentTime
{
    NSString *fullTime = [NSString stringWithFormat:@"%@ %@",_currentDate,_currentTime];
    return fullTime;
}

@end
