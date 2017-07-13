//
//  CBTimeLine.h
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/6.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBTimeLineTopPositionModel.h"

@interface CBTimeLine : NSObject

/************************用于画分时线的画笔************************/

@property(nonatomic,strong) NSArray *positionModels;

@property(nonatomic,assign) CGFloat horizontalYPosition;

@property(nonatomic,assign) CGFloat timeLineViewWidth;

-(instancetype)initWithContext:(CGContextRef)context;

-(void)draw;

@end
