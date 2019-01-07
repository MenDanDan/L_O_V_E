//
//  WBPopContentView.m
//  alertViews
//
//  Created by Macx on 2018/12/29.
//  Copyright © 2018年 55556. All rights reserved.
//

#import "WBPopContentView.h"
@interface WBPopContentView ()

/**
 view的标识
 */
@property (nonatomic, assign)WBPopContent_TYPE type;
//底部view   公共
//@property (nonatomic, strong)UIView *bgView;//0

@property (nonatomic, strong) UILabel *contentLabel;//1

@end
@implementation WBPopContentView

-(instancetype)initWithFrame:(CGRect)frame andType:(WBPopContent_TYPE)type {
    if (self = [super initWithFrame:frame]) {
        
        self.type = type;
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.masksToBounds = YES;
        
        switch (type)
        {
            case WBPopContent_TYPE_Custom:
                self.height = 100.0;
                break;
                
            case WBPopContent_TYPE_Lable:
            {
                [self addSubview:self.contentLabel];
                self.contentLabel.text = @"即享受店铺优惠结算后再全单打折优惠；例：此处设置为90，即享受全单优惠的9折优惠，以消费100元计算，本单需支付金额90元。";
                self.contentLabel.frame = CGRectMake(10, 10, frame.size.width-20, 0);
                [self.contentLabel sizeToFit];
                self.height = self.contentLabel.bottom+10;
            }
                break;
            default:
                break;
        }
    }
    return self;
}

-(UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _contentLabel.font = MediumFont(13);
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
