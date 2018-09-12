//
//  WMPop2ViewController.m
//  alertViews
//
//  Created by 55556 on 2018/9/12.
//  Copyright © 2018年 55556. All rights reserved.
//

#import "WMPop2ViewController.h"

@interface WMPop2ViewController ()

@property (nonatomic, assign) NSInteger flag;
@end

@implementation WMPop2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
    
    for (int i=0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor cyanColor]];
        btn.tag = i;
        btn.frame = CGRectMake(100, 200+40*i, 30, 30);
        [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- privateSelector

-(void)buttonAction:(UIButton *)button {
    self.flag = button.tag;
    [self createShapeLayer];
}

-(void)dismiss {
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

#pragma mark -- CAshapeLayer
-(void)createShapeLayer {
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.frame = CGRectMake(20 + 50*self.flag, 100, 40, 40);
    //背景颜色
    layer.backgroundColor = [UIColor cyanColor].CGColor;
    //设置描边颜色
    layer.strokeColor = [UIColor blackColor].CGColor;
    //填充色
    layer.fillColor = [UIColor redColor].CGColor;
    
    UIBezierPath *path ;
    switch (self.flag) {
        case 0:
        {   //矩形
            path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 40, 40)];
        }
            break;
        case 1:
        {  //圆形
            path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 40, 40)];
        }
            break;
        case 2:
        {   //圆角
            path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 40, 40) cornerRadius:4.0];
        }
            break;
        case 3:
        {  //指定矩形某个角加圆角
            path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 40, 40) byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(4, 4)];
        }
            break;
        default:
            break;
    }
    //贝塞尔曲线
    layer.path = path.CGPath;
    
    [self.view.layer addSublayer:layer];
}

@end
