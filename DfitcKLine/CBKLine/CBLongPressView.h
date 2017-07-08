//
//  CBLongPressView.h
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/8.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBTimeLineModel;

@interface CBLongPressView : UIView

+(instancetype)timeLineLongPressProfileView;

@property(nonatomic,strong) CBTimeLineModel *timeLineModel;

@end
