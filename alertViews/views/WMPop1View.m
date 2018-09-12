//
//  WMPop1View.m
//  alertViews
//
//  Created by 55556 on 2018/9/11.
//  Copyright © 2018年 55556. All rights reserved.
//

#import "WMPop1View.h"
#define kScreenWidth               [UIScreen mainScreen].bounds.size.width
#define kScreenHeight              [UIScreen mainScreen].bounds.size.height
#define kMainWindow                [UIApplication sharedApplication].keyWindow

@interface WMPop1View ()
@property (nonatomic, strong) UIView *bgV;

@property (nonatomic, strong) UIView *contentV;

@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation WMPop1View

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
        [self addConstraints];
    }
    return self;
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self viewDismiss];
//}

#pragma mark -- privateSelector
-(void)viewShow {
    self.bgV.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    kMainWindow.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [kMainWindow addSubview:self.bgV];
    
    [kMainWindow addSubview:self];
    self.alpha = 0.0;
    self.bgV.alpha = 0.0;
    self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 1;
        self.bgV.alpha = 1;
        self.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)viewDismiss {
    self.alpha = 1.0;
    self.bgV.alpha = 1.0;
    self.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0.0f;
        self.bgV.alpha = 0.0f;
        self.layer.affineTransform = CGAffineTransformMakeScale(0.0, 0.0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.bgV removeFromSuperview];
    }];
}

#pragma mark -- tap
-(void)tap {
    [self viewDismiss];
}

#pragma mark -- init
-(UIView *)contentV {
    if (!_contentV) {
        _contentV = [[UIView alloc]init];
        _contentV.backgroundColor = [UIColor whiteColor];
    }
    return _contentV;
}

-(UIView *)bgV {
    if (!_bgV) {
        _bgV = [[UIView alloc]init];
        _bgV.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [_bgV addGestureRecognizer:tap];
    }
    return _bgV;
}

-(UILabel *)titleLabel {

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"温馨提示";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark -- addSubviews

-(void)addSubviews {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self addSubview:self.contentV];
    [self.contentV addSubview:self.titleLabel];
}

#pragma mark -- addconstraints
-(void)addConstraints {
  
    self.contentV.frame = self.bounds;
    self.titleLabel.frame = CGRectMake(30, 30, 215, 20);
}

@end
