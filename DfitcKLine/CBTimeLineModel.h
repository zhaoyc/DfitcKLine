//
//  CBTimeLineModel.h
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/6.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CBTimeLineModel : NSObject

@property(nonatomic,assign) CGFloat currentPrice;

@property(nonatomic,copy) NSString *currentTime;

@property(nonatomic,copy) NSString *currentDate;

@property(nonatomic,assign) NSInteger volume;

@property(nonatomic,assign) CGFloat ChangeFromPreClose;

@property(nonatomic,assign) CGFloat PercentChangeFromPreClose;

@end
