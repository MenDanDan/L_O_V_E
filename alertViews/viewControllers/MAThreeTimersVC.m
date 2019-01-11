//
//  MAThreeTimersVC.m
//  alertViews
//
//  Created by Macx on 2019/1/8.
//  Copyright © 2019年 55556. All rights reserved.
///Users/Macx/Desktop/项目资料文件/L_O_V_E/alertViews/viewControllers/MAThreeTimersVC.m

#import "MAThreeTimersVC.h"

@interface MAThreeTimersVC ()
//屏幕刷新频率激发 不受runloop影响 currentTimerIndex = 1
@property (nonatomic, strong) CADisplayLink *linkTimer;
//runloop currentTimerIndex = 2
@property (nonatomic, strong) NSTimer *timer;
//GCD预留的原类型对象 不受runloop影响 currentTimerIndex = 3
@property (nonatomic, strong) dispatch_source_t dispatchTimer;

@property (nonatomic, assign) NSInteger currentIndex;
//展示的动画
@property (nonatomic, strong) UIImageView *imgV;

@property (nonatomic, strong) NSArray *btnsArr;
//当前选中timer的方式
@property (nonatomic, assign) NSInteger currentTimerIndex;

@end

@implementation MAThreeTimersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI
{
    [self.view addSubview:self.imgV];
    for (int i=0; i<self.btnsArr.count; i++)
    {
        UIButton *btn = self.btnsArr[i];
        [self.view addSubview:btn];
    }
    
    self.imgV.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-140)/2.0,40+180 , 140, 140);
    for (int i=0; i<self.btnsArr.count; i++)
    {
        UIButton *btn = self.btnsArr[i];
        btn.frame = CGRectMake(120*i + 10, 200+200, 120-20,40);
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds=YES;
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [UIColor grayColor].CGColor;
    }
}

-(CADisplayLink *)linkTimer
{
    if (!_linkTimer)
    {
        _linkTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeImage)];
        //触发间隔
        _linkTimer.frameInterval = 2;
        //加入一个runloop
        [_linkTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
    }
    return _linkTimer;
}

- (NSTimer *)timer
{
    if (!_timer)
    {
        _timer = [NSTimer timerWithTimeInterval:0.032 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (dispatch_source_t)dispatchTimer
{
    if (!_dispatchTimer)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            self.dispatchTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
            dispatch_source_set_timer(self.dispatchTimer, dispatch_walltime(NULL, 0 * NSEC_PER_SEC ), 0.032 * NSEC_PER_SEC, 0);
            dispatch_source_set_event_handler(self.dispatchTimer, ^{
                [self changeImage];
            });
        });
    }
    return _dispatchTimer;
}


-(UIImageView *)imgV
{
    if (!_imgV)
    {
        _imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        _imgV.layer.cornerRadius = 5.0;
        _imgV.layer.masksToBounds = YES;
    }
    return _imgV;
}


-(NSArray *)btnsArr
{
    if (!_btnsArr)
    {
        NSArray *titles = @[@"CADisplayLink",@"NSTimer",@"dispatch_source_t"];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (int i=0; i<titles.count; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn.titleLabel setFont:MediumFont(13)];
            btn.tag = i;
            [btn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(switchTimerAction:) forControlEvents:UIControlEventTouchUpInside];
            [tempArr addObject:btn];
        }
        _btnsArr = (NSArray *)tempArr;
    }
    return _btnsArr;
}


- (void)switchTimerAction:(UIButton *)btn
{
    if (self.currentTimerIndex && (btn.tag == self.currentTimerIndex - 1))
    {
        return;
    }
    
    self.currentIndex = 0;

    switch (self.currentTimerIndex) {
        case 1:
        {
            self.linkTimer.paused = YES;
            [self.linkTimer invalidate];
            self.linkTimer = nil;
        }
            break;
        case 2:
        {
            [self.timer invalidate];
            self.timer = nil;
        }
            break;
        case 3:
        {
//            dispatch_cancel(self.dispatchTimer);
//            self.dispatchTimer = nil;
            //切换时用暂停 否则会崩溃
            dispatch_suspend(self.dispatchTimer);
        }
            break;
        case 0:
            
            break;
        default:
            break;
    }
    
    self.currentTimerIndex = btn.tag + 1;
    
    switch (btn.tag) {
        case 0://CADisplayLink
        {
            self.linkTimer.paused = NO;
        }
            break;
        case 1://NSTimer
        {
            [self.timer fire];
            ///恢复计时器
//            self.timer.fireDate = [NSDate distantPast];
        }
            break;
        case 2://dispatch_source_t
        {
            dispatch_resume(self.dispatchTimer);
//            dispatch_suspend(self.dispatchTimer);
        }
            break;
        default:
            break;
    }
}

- (void)changeImage
{
    self.currentIndex ++;
    if (self.currentIndex > 75)
    {
        self.currentIndex = 1;
    }
    self.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",self.currentIndex]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.linkTimer invalidate];
    self.linkTimer = nil;
    
    [self.timer invalidate];
    self.timer = nil;
    
    dispatch_cancel(self.dispatchTimer);
    self.dispatchTimer = nil;
}

@end
