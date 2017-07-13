//
//  CBKLineConstant.m
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/8.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#ifndef __CBKLineConstant__M__
#define __CBKLineConstant__M__

#import <UIKit/UIKit.h>
/**
 *  K线图需要加载更多数据的通知
 */
NSString * const CBKLineNeedLoadMoreDataNotification = @"CBKLineNeedLoadMoreDataNotification";

/**
 *  K线图Y的View的宽度
 */
CGFloat const CBKLinePriceViewWidth = 50;

/**
 *  K线图的X的View的高度
 */
CGFloat const CBKChartTimeViewHeight = 20;

/**
 *  K线最大的宽度
 */
CGFloat const CBKLineMaxWidth = 27;

/**
 *  K线图最小的宽度
 */
CGFloat const CBKLineMinWidth = 2;

/**
 *  K线图缩放界限
 */
CGFloat const CBKChartScaleBound = 0.03;

/**
 *  K线的缩放因子
 */
CGFloat const CBKChartScaleFactor = 0.03;

/**
 *  UIScrollView的contentOffset属性
 */
NSString * const CBKChartContentOffsetKey = @"contentOffset";

/**
 *  时分线的宽度
 */
CGFloat const CBKChartTimeLineLineWidth = 0.5;

/**
 *  时分线图的Above上最小的X
 */
CGFloat const CBKChartTimeLineAboveViewMinX = 0.0;

/**
 *  分时线的timeLabelView的高度
 */
CGFloat const CBKChartTimeLineTimeLabelViewHeight = 19;

/**
 *  时分线的成交量的线宽
 */
CGFloat const CBKChartTimeLineVolumeLineWidth = 0.5;

/**
 *  长按时的线的宽度
 */
CGFloat const CBKChartLongPressVerticalViewWidth = 0.5;

/**
 *  MA线的宽度
 */
CGFloat const CBKChartMALineWidth = 1;



#endif
