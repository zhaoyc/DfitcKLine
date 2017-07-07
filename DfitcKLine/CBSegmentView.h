//
//  CBSegmentView.h
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/7.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CBKLineSegmentDelegate <NSObject>

@optional
-(void)cBKLineSegmentSelectedAtIndex:(NSUInteger)selectedIndex;

@end
@interface CBSegmentView : UIView

/**
 *  通过items创建SegmentView
 */
-(instancetype)initWithItems:(NSArray *)items;


@property(nonatomic,strong) NSArray *items;


@property(nonatomic,weak) id<CBKLineSegmentDelegate> delegate;

@property(nonatomic,assign) NSUInteger selectedIndex;

@end

