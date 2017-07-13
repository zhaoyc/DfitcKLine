//
//  CBTimeLineBottomVolum.h
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/8.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CBTimeLineBottomVolum : NSObject

@property(nonatomic,strong) NSArray *timeLineVolumnPositionModels;

-(instancetype)initWithContext:(CGContextRef)context;

-(void)draw;

@end
