//
//  WMPopViewController.h
//  alertViews
//
//  Created by 55556 on 2018/9/11.
//  Copyright © 2018年 55556. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WMPopViewControllerDelegate  <NSObject>

-(void)dismissVC;

@end

@interface WMPopViewController : UIViewController

@property (nonatomic, weak) id<WMPopViewControllerDelegate>delegate;

@end
