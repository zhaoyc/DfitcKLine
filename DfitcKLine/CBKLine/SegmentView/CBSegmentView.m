//
//  CBSegmentView.m
//  DfitcKLine
//
//  Created by 赵彦超 on 2017/7/7.
//  Copyright © 2017年 Dfitc. All rights reserved.
//

#import "CBSegmentView.h"
#import "Masonry.h"

static NSInteger const CBKLineSegmentStartTag = 2000;

static CGFloat const CBKLineSegmentIndicatorViewHeight = 2;

static CGFloat const CBKLineSegmentIndicatorViewWidth = 40;


@interface CBSegmentView ()

@property(nonatomic,strong,readwrite) UIButton *selectedBtn;

@property(nonatomic,strong) UIView *indicatorView;

@end


@implementation CBSegmentView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}



#pragma mark - getter

-(UIView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [UIView new];
        _indicatorView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_indicatorView];
        [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-CBKLineSegmentIndicatorViewHeight);
            make.height.equalTo(@(CBKLineSegmentIndicatorViewHeight));
            make.width.equalTo(@(CBKLineSegmentIndicatorViewWidth));
            make.centerX.equalTo(self);
        }];
    }
    return _indicatorView;
}

#pragma mark - set方法
#pragma mark items的set方法
-(void)setItems:(NSArray *)items
{
    _items = items;
    if (items.count == 0 || !items) {
        return;
    }
    NSInteger index = 0;
    NSInteger count = items.count;
    UIButton *preBtn = nil;
    for (NSString *title in items) {
        UIButton *btn = [self private_createButtonWithTitle:title tag:CBKLineSegmentStartTag+index];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom).offset(-2);
            make.width.equalTo(self).multipliedBy(1.0f/count);
            if (preBtn) {
                make.left.equalTo(preBtn.mas_right);
            }else{
                make.left.equalTo(self);
            }
        }];
        preBtn = btn;
        index++;
    }
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    UIButton *btn = (UIButton *)[self viewWithTag:CBKLineSegmentStartTag+selectedIndex];
    NSAssert(btn, @"Segmetn的按钮还没有初始化完毕!");
    [self event_segmentButtonClicked:btn];
}

-(void)setSelectedBtn:(UIButton *)selectedBtn
{
    if (_selectedBtn == selectedBtn) {
        return;
    }
    _selectedBtn = selectedBtn;
    _selectedIndex = selectedBtn.tag - CBKLineSegmentStartTag;
    [self.indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-CBKLineSegmentIndicatorViewHeight);
        make.height.equalTo(@(CBKLineSegmentIndicatorViewHeight));
        make.width.equalTo(@(CBKLineSegmentIndicatorViewWidth));
        make.centerX.equalTo(selectedBtn.mas_centerX);
    }];
    [UIView animateWithDuration:0.2f animations:^{
        [self layoutIfNeeded];
    }];
}

#pragma mark - private method

-(UIButton *)private_createButtonWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    btn.tag = tag;
    [btn addTarget:self action:@selector(event_segmentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

#pragma mark - events
-(void)event_segmentButtonClicked:(UIButton *)btn
{
    self.selectedBtn = btn;
    if (self.delegate && [self.delegate respondsToSelector:@selector(cBKLineSegmentSelectedAtIndex:)]) {
        [self.delegate cBKLineSegmentSelectedAtIndex:btn.tag-CBKLineSegmentStartTag];
    }
}

@end
