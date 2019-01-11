//
//  WMAnimationViewController.m
//  alertViews
//
//  Created by Macx on 2019/1/9.
//  Copyright © 2019年 55556. All rights reserved.
//

#import "WMAnimationViewController.h"

@interface WMAnimationViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIView *myView1;

//action4 转场动画
@property (nonatomic, assign) NSInteger flag ;

@property (nonatomic, strong) UIImageView *imgView4;

@property (nonatomic, strong) NSArray *gifArr;
@end

@implementation WMAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i=0; i<7; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 100+50*i, 44, 44);
        btn.tag = i+1;
        [btn addTarget:self action:@selector(btnsAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor blueColor]];
        btn.layer.cornerRadius  = 22.0;
        btn.layer.masksToBounds = YES;
        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:MediumFont(15)];
        [self.view addSubview:btn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnsAction:(UIButton *)button
{
    switch (button.tag) {
        case 1://CABasicAnimation
            [self action1:button];
            break;
        case 2://CAKeyframeAnimation
            [self action2:button];
            break;
        case 3://CAAnimationGroup
            [self action3:button];
            break;
        case 4://CATransition
            [self action4:button];
            break;
        case 5://Gif简单动画实现
            [self action5:button];
            break;
        case 6://Gif简单动画实现
            [self action5:button];
            break;
        case 7://Gif简单动画实现
            [self action5:button];
            break;
        default:
            break;
    }
}

- (void)action1:(UIButton *)button
{
    [self initMyView];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation1.removedOnCompletion = NO;
    animation1.fillMode = kCAFillModeBackwards;
    animation1.duration = 2;
    animation1.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 200)];

    animation1.beginTime = CACurrentMediaTime() + 1;
    animation1.repeatCount = 3;
    //addAnimation:animation1 forKey:nil 对annimation进行了copy 添加在图层上 添加之后 再也不能修改annimation
    [self.myView1.layer addAnimation:animation1 forKey:nil];
    
}

- (void)action2:(UIButton *)button
{
    //CAKeyframeAnimation 继承 CAPropertyAnimation
    //CABasicAnimation   继承 CAPropertyAnimation
    //顾名思义 根据属性来实现动画 不同处 CAKeyframeAnimation可以指定多个状态 不只是始末状态
    [self initMyView];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.values = @[[NSValue valueWithCGPoint:CGPointMake(50, 50)],[NSValue valueWithCGPoint:CGPointMake(100, 200)],[NSValue valueWithCGPoint:CGPointMake(50, 50)]];//50,50 是锚点 第一个value是起点 最后一个是终点
    animation.duration = 2;
//    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //animation.calculationMode = kCAAnimationCubicPaced;//改变转折点出现的平滑度 CAKeyframeAnimation独有的属性
//    animation.keyTimes = @[@0,@0.25,@0.5,@0.75,@1];//0.8 是执行时间与总时间的比值
    animation.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 200)].CGPath;//当设置path属性，此时values属性将被忽略 此时为CGPathRef类型数据 为什么？ 还记得之前说的UIKit的事？动画里面的属性不能赋值UIkit中 因为CALayer是iOS和OS X系统共用的，osx不支持UIKit
    //path 填写了values keytimes要对应 圆形路径 被分成了4个子路径
//    animation.rotationMode = kCAAnimationRotateAuto;//模拟端点的转动
    [self.myView1.layer addAnimation:animation forKey:@"keyframe"];//key可以为nil
    NSLog(@"---x:%lf , y: %lf",self.myView1.layer.position.x,self.myView1.layer.position.y);
}

- (void)action3:(UIButton *)button
{
    [self initMyView];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 2;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.keyTimes = @[@0,@0.25,@0.5,@0.75,@1];
    animation.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)].CGPath;
    animation.beginTime = 1;//不用加矫正时间
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation1.toValue = @50;
    animation1.duration = 2;
    animation1.removedOnCompletion = NO;
    animation1.fillMode = kCAFillModeForwards;
    animation1.beginTime = 3;//不用加矫正时间
    
    CAAnimationGroup *group = [CAAnimationGroup animation];//因为CAAnimationGroup可以播放多个属性同时变化，所以不需要指定属性 也继承CAAnimation 所以可以嵌套成  animations
    group.duration = 5;//不用加矫正时间内
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.animations = @[animation,animation1];
    [self.myView1.layer addAnimation:group forKey:@"group"];// @"group" 不可省略
    
    //animations数组中你的所有CAAnimaiton对象请安beginTime进行升序排列哦，否则也是会有问题的 本人试过未发现问题
}

- (void)action4:(UIButton *)button
{
    if (self.myView1)
    {
        [self.myView1 removeFromSuperview];
        self.myView1 = nil;
    }
    
    if (self.imgView4)
    {
        CATransition *animation = [CATransition animation];
        animation.duration = 5.0;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        //@"cube" @"moveIn" @"reveal" @"fade"(default) @"pageCurl" @"pageUnCurl" @"suckEffect" @"rippleEffect" @"oglFlip" 系统私有动画
        animation.type = @"rippleEffect";
        animation.subtype = kCATransitionFromTop;
        [self.imgView4.layer addAnimation:animation forKey:@"ripple"];
        if (_flag == 0 || _flag == 2)
        {
            self.imgView4.image = [UIImage imageNamed:@"grzx_icon_tyk_04"];
            _flag = 1;
        }else {
            self.imgView4.image = [UIImage imageNamed:@"grzx_icon_tyk_03"];
            _flag = 2;
        }
    }
    else
    {
        self.imgView4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"grzx_icon_tyk_03"]];
        self.imgView4.frame = CGRectMake(200, 300, 60, 60);
        [self.view addSubview:self.imgView4];
    }
}

- (void)action5:(UIButton *)button
{
    if (self.myView1)
    {
        [self.myView1 removeFromSuperview];
        self.myView1 = nil;
    }
    
    if (self.imgView4)
    {
        [self.imgView4 removeFromSuperview];
        self.imgView4 = nil;
    }
    self.imgView4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"grzx_icon_tyk_03"]];
    self.imgView4.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2.0, ([UIScreen mainScreen].bounds.size.height - 200)/2.0,150*2, 200);
    [self.view addSubview:self.imgView4];
    
    CAKeyframeAnimation *annimation = [self createGIFAnimation];
    [self.imgView4.layer addAnimation:annimation forKey:@"contents"];
}

//https://upload-images.jianshu.io/upload_images/4162257-2cbfad0e5e1ff599.gif?imageMogr2/auto-orient/strip
- (CAKeyframeAnimation *)createGIFAnimation
{
    NSURL *url = [NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/4162257-2cbfad0e5e1ff599.gif?imageMogr2/auto-orient/strip"];
    NSMutableArray *delayTimeArr = [NSMutableArray array];
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    size_t count = CGImageSourceGetCount(imageSource);
    
    NSMutableArray *gifArr   = [NSMutableArray array];
    NSMutableArray *keyTimes = [NSMutableArray array];
    
    for (size_t i=0; i<count; i++)
    {
        CGImageRef image = CGImageSourceCreateImageAtIndex(imageSource, i, NULL);
        [gifArr addObject:CFBridgingRelease(image)];
        NSDictionary *dic = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(imageSource, i, NULL));
        [delayTimeArr addObject:[[dic valueForKey:(NSString *)kCGImagePropertyGIFDictionary] valueForKey:@"DelayTime"]];
    }
//    self.gifArr = (NSArray *)gifArr;
    CGFloat totalTime = 0;
    for (NSNumber *delay in delayTimeArr) {
        totalTime += delay.floatValue;
    }
    
    [keyTimes addObject:@0];
    CGFloat currentTime = 0;
    for (NSNumber *delay in delayTimeArr) {
        currentTime += delay.floatValue;
        [keyTimes addObject:@(currentTime/totalTime)];
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    animation.duration = totalTime;
    animation.values = gifArr;
    animation.keyTimes = keyTimes;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    return animation;
}

- (void)action6:(UIButton *)button
{
    
}

#pragma mark **** CAAnimationDelegate ****
-(void)animationDidStart:(CAAnimation *)anim
{
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (!flag)
    {//动画未执行完成
        NSLog(@"---x:%lf , y: %lf",self.myView1.layer.position.x,self.myView1.layer.position.y);
    }
}

#pragma  mark **** 初始化myview ****

- (void)initMyView
{
    if (self.imgView4)
    {
        [self.imgView4 removeFromSuperview];
        self.imgView4 = nil;
    }
    
    if (self.myView1)
    {
        [self.myView1 removeFromSuperview];
        self.myView1 = nil;
    }
    
    self.myView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.myView1.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.myView1];
}


@end
