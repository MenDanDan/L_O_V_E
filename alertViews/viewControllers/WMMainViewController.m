//
//  WMMainViewController.m
//  alertViews
//
//  Created by 55556 on 2018/9/11.
//  Copyright © 2018年 55556. All rights reserved.
//

#import "WMMainViewController.h"

#import "WMPopViewController.h"

#import "WMPop1View.h"

#import "WMPop2ViewController.h"

@interface WMMainViewController ()<WMPopViewControllerDelegate>

@property (nonatomic, strong) WMPopViewController *popV;

@property (nonatomic, strong) WMPop1View *pop1V;
@end

@implementation WMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (int i=0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor redColor]];
        btn.frame = CGRectMake(100, 100+50*i, 40, 40);
        btn.tag = i;
        [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.view addSubview:btn];
    }
}

#pragma mark -- privateSelector
-(void)clickButtonAction:(UIButton *)button {
    NSInteger tag = button.tag;
    switch (tag) {
        case 0:
            {
                __weak typeof(self) weakSelf = self;
                self.popV.view.alpha = 0.0;
                [self presentViewController:self.popV animated:NO completion:^{
                    [UIView animateWithDuration:0.4 animations:^{
                        __strong typeof(self) strongSelf = weakSelf;
                        strongSelf.popV.view.alpha = 1.0;
                    }];
                }];
            }
            break;
            case 1:
        {
            [self.pop1V viewShow];
        }
            break;
        case 2:
        {
            WMPop2ViewController *shapeLayerVC = [[WMPop2ViewController alloc]init];
            shapeLayerVC.view.backgroundColor = [UIColor whiteColor];
            [self presentViewController:shapeLayerVC animated:NO completion:^{
                
            }];
        }
            break;
        default:
            break;
    }
 
}

-(WMPop1View *)pop1V {
    if (!_pop1V) {
        _pop1V = [[WMPop1View alloc]initWithFrame:CGRectMake(50, 200, 275, 100)];
    }
    return _pop1V;
}

-(WMPopViewController *)popV {
    if (!_popV) {
        _popV = [[WMPopViewController alloc]init];
        _popV.modalPresentationStyle = UIModalPresentationCustom;
        _popV.delegate = self;
    }
    return _popV;
}

#pragma mark -- WMPopViewControllerDelegate
-(void)dismissVC {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.popV.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf dismissViewControllerAnimated:strongSelf.popV completion:^{
            
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
