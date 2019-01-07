//
//  WBPopContentView.h
//  alertViews
//
//  Created by Macx on 2018/12/29.
//  Copyright © 2018年 55556. All rights reserved.
//

#import <UIKit/UIKit.h>
//区别view的类型
typedef  NS_ENUM(NSInteger,WBPopContent_TYPE) {
    WBPopContent_TYPE_Custom = 0,
    WBPopContent_TYPE_Lable  = 1
};
@interface WBPopContentView : UIView

-(instancetype)initWithFrame:(CGRect)frame andType:(WBPopContent_TYPE)type;

@end
