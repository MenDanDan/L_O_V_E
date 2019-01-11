//
//  WBPopOverView.h
//  pop_test
//
//  Created by tuhui－03 on 16/5/19.
//  Copyright © 2016年 tuhui－03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "WBPopContentView.h"

typedef NS_ENUM(NSUInteger,WBArrowDirection){

    //箭头位置
    
    WBArrowDirectionLeft1=1,//左上
    WBArrowDirectionLeft2,//左中
    WBArrowDirectionLeft3,//左下
    WBArrowDirectionRight1,//右上
    WBArrowDirectionRight2,//右中
    WBArrowDirectionRight3,//右下
    WBArrowDirectionUp1,//上左
    WBArrowDirectionUp2,//上中
    WBArrowDirectionUp3,//上右
    WBArrowDirectionDown1,//下左
    WBArrowDirectionDown2,//下中
    WBArrowDirectionDown3,//下右

};

@interface WBPopOverView : UIView
@property (nonatomic, strong) WBPopContentView  *backView;

-(instancetype)initWithOrigin:(CGPoint)origin Width:(CGFloat)width Height:(CGFloat)height Direction:(WBArrowDirection)direction Type:(WBPopContent_TYPE)type;

-(void)popView;//弹出视图
-(void)dismiss;//隐藏视图

@end
