//
//  CBKLineConstant.h
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/8.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#ifndef __CBKLineConstant__H__
#define __CBKLineConstant__H__

#import <UIKit/UIKit.h>


/**
 *  K线图需要加载更多数据的通知
 */
extern NSString * const CBKLineNeedLoadMoreDataNotification;

/**
 *  K线图Price的View的宽度
 */
extern CGFloat const CBKLinePriceViewWidth;

/**
 *  K线图的Time的View的高度
 */
extern CGFloat const CBKChartTimeViewHeight;

/**
 *  K线最大的宽度
 */
extern CGFloat const CBKLineMaxWidth;

/**
 *  K线图最小的宽度
 */
extern CGFloat const CBKLineMinWidth;

/**
 *  UIScrollView的contentOffset属性
 */
extern NSString * const CBKChartContentOffsetKey;

/**
 *  K线图缩放界限
 */
extern CGFloat const CBKChartScaleBound;

/**
 *  K线的缩放因子
 */
extern CGFloat const CBKChartScaleFactor;

/**
 *  K线图上可画区域最小的Y
 */
#define CBKLineAboveViewMinY 20

/**
 *  K线图上可画区域最大的Y
 */
#define CBKLineAboveViewMaxY (self.frame.size.height-20)

/**
 *  K线图的成交量上最小的Y
 */
#define CBKLineBelowViewMinY 0

/**
 *  K线图的成交量最大的Y
 */
#define CBKLineBelowViewMaxY (self.frame.size.height)


/**
 *  时分线图的Above上最小的Y
 */
#define CBKChartTimeLineAboveViewMinY 0

/**
 *  时分线图的Above上最大的Y
 */
#define CBKChartTimeLineAboveViewMaxY (self.frame.size.height)

/**
 *  时分线图的Above上最小的X
 */
extern CGFloat const CBKChartTimeLineAboveViewMinX;

/**
 *  时分线的宽度
 */
extern CGFloat const CBKChartTimeLineLineWidth;

/**
 *  时分线图的Above上最大的Y
 */
#define CBKChartTimeLineAboveViewMaxX (self.frame.size.width)

/**
 *  时分线图的Below上最小的Y
 */
#define CBKChartTimeLineBelowViewMinY 0

/**
 *  时分线图的Below上最大的Y
 */
#define CBKChartTimeLineBelowViewMaxY (self.frame.size.height)

/**
 *  时分线图的Below最大的X
 */
#define CBKChartTimeLineBelowViewMaxX (self.frame.size.width)

/**
 * 时分线图的Below最小的X
 */
#define CBKChartTimeLineBelowViewMinX 0

/**
 *  时分线的成交量的线宽
 */
extern CGFloat const CBKChartTimeLineVolumeLineWidth;

/**
 *  分时线的timeLabelView的高度
 */
extern CGFloat const CBKChartTimeLineTimeLabelViewHeight;

/**
 *  长按时的线的宽度
 */
extern CGFloat const CBKChartLongPressVerticalViewWidth;


/**
 *  MA线的宽度
 */
extern CGFloat const CBKChartMALineWidth;


//枚举
typedef NS_ENUM(NSUInteger, CBKChartViewType){
    CBKChartViewTypeKLine = 1,    //K线
    CBKChartViewTypeTimeLine     //分时线
};

#endif
