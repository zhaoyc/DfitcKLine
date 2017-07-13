//
//  CBTimeLineModelGroup.h
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/8.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CBTimeLineModel.h"

@interface CBTimeLineModelGroup : NSObject

/**
 *  这个数组装得是CBTimeLineModel
 */
@property(nonatomic,strong) NSArray *timeModels;

@property(nonatomic,assign) CGFloat lastDayEndPrice;

+(instancetype)groupModelWithTimeModels:(NSArray *)timeModels lastDayEndPrice:(CGFloat)lastDayEndPrice;

@end
