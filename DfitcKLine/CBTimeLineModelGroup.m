//
//  CBTimeLineModelGroup.m
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/8.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import "CBTimeLineModelGroup.h"
#import "MJExtension.h"

@implementation CBTimeLineModelGroup

+(instancetype)groupModelWithTimeModels:(NSArray *)timeModels lastDayEndPrice:(CGFloat)lastDayEndPrice
{
    CBTimeLineModelGroup *groupModel = [[CBTimeLineModelGroup alloc] init];
    groupModel.timeModels = timeModels;
    groupModel.lastDayEndPrice = lastDayEndPrice;
    return groupModel;
}

@end
