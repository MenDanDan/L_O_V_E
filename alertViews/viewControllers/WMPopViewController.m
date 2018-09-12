//
//  WMPopViewController.m
//  alertViews
//
//  Created by 55556 on 2018/9/11.
//  Copyright © 2018年 55556. All rights reserved.
//

#import "WMPopViewController.h"

@interface WMPopViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *sure_button;

@end

@implementation WMPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSubviews];
    [self layoutSubviews];
    self.view.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- addSubviews
-(void)addSubviews {
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.messageLabel];
    [self.contentView addSubview:self.sure_button];
}

#pragma mark -- layoutSubviews

-(void)layoutSubviews {
    self.contentView.frame = CGRectMake(30, 200, 315, 100);
    self.titleLabel.frame = CGRectMake(10, 10, 295, 20);
    self.messageLabel.frame = CGRectMake(20, 40, 260, 20);
    self.sure_button.frame = CGRectMake(70, 65, 150, 30);
}
#pragma  mark -- init
-(UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 4.0;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}
-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"温馨提示";
    }
    return _titleLabel;
}

-(UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = [UIFont systemFontOfSize:12.0];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.text = @"您的账户余额不足，请及时充值";
    }
    return _messageLabel;
}

-(UIButton *)sure_button {
    if (!_sure_button) {
        _sure_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sure_button setTitle:@"确定" forState:UIControlStateNormal];
        [_sure_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sure_button addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sure_button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_sure_button setBackgroundColor:[UIColor redColor]];
    }
    return _sure_button;
}

-(void)sureButtonAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissVC)]) {
        [self.delegate dismissVC];
    }
}
@end

