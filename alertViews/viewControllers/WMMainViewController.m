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
#import "WBPopOverView.h"
//5
#import "MMTimerViewController.h"

@interface WMMainViewController ()<WMPopViewControllerDelegate>

@property (nonatomic, strong) WMPopViewController *popV;

@property (nonatomic, strong) WMPop1View *pop1V;

@property (nonatomic, strong) WBPopOverView *popOverView;

@property (nonatomic, strong) NSThread *thread;

@end

@implementation WMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (int i=0; i<6; i++) {
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

-(WBPopOverView *)popOverView {
    if (!_popOverView) {
        _popOverView = [[WBPopOverView alloc]initWithOrigin:CGPointMake(100,200 ) Width:100 Height:100 Direction:WBArrowDirectionUp2 Type:WBPopContent_TYPE_Lable];
    }
    return _popOverView;
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
            [self.popOverView popView];
        }
            break;
        case 3://3.4串行 执行任务 3.创建子线程 task task2 顺序执行
        {
            self.thread = [[NSThread  alloc]initWithTarget:self selector:@selector(task1) object:nil];
            [self.thread start];
        }
            break;
        case 4:
        {//子线程任务
            [self performSelector:@selector(task2) onThread:self.thread withObject:nil waitUntilDone:YES];
        }
            break;
        case 5:
        {//定时器
            [self action5];
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

#pragma mark ****** 顺序执行多个任务 方法3.4 ******
- (void)task1 {
    NSLog(@"%@",[NSThread currentThread]);
    
    //解决方法：开runloop 防止子线程死掉 必须在自县城获取runloop 至少有一个source或者是timer
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    
    //开启runloop方法1 一直执行task方法
//    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(task) userInfo:nil repeats:YES];
//    [runloop addTimer:timer forMode:NSDefaultRunLoopMode];
//    [runloop run];
    //开启runloop方法2 20秒后关闭
    [runloop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [runloop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:20]];
    
}

- (void)task2 {
    NSLog(@"task2-%@",[NSThread currentThread]);
}

- (void)task {
    NSLog(@"task1-%@",[NSThread currentThread]);
}

#pragma mark **** 定时器的使用 ******
-(void)action5
{
    MMTimerViewController *timerVC = [[MMTimerViewController alloc]init];
    timerVC.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:timerVC animated:YES completion:nil];
}

@end
