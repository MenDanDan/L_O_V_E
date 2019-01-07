//
//  WMTimerTVC.m
//  alertViews
//
//  Created by Macx on 2019/1/4.
//  Copyright © 2019年 55556. All rights reserved.
//

#import "WMTimerTVC.h"
@interface WMTimerTVC ()

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) NSTimer *timer;
@end
@implementation WMTimerTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    grzx_icon_tyk_01
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView addSubview:self.timeLabel];
        self.timeLabel.frame = CGRectMake(0, 0, 220, 40);
        [self addTimer];
    }
    return self;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel)
    {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = MediumFont(13);
        _timeLabel.textColor = [UIColor redColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

#pragma mark **** 创建定时器 ****
-(void)addTimer
{
    //创建timer的几种方式
    NSInteger switchValue = 2;
    if (switchValue == 1)
    {
        //1.自己创建runLoop
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(refreshLabel) userInfo:nil repeats:YES];
        //1.1NSDefaultRunLoopMode 滚动时停止 添加UITrackingRunLoopMode滚动正常
        [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop mainRunLoop]addTimer:timer forMode:UITrackingRunLoopMode];
        //1.2NSRunLoopCommonModes 滚动时正常
        // [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
        
        self.timer = timer;
        [timer fire];

    }else if (switchValue == 2)
    {
        //创建完自动加入到 NSDefaultRunLoopMode中
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshLabel) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:timer forMode:UITrackingRunLoopMode];
        self.timer = timer;
        [timer fire];
    }
}

#pragma mark **** praviterSelector ****

- (void)refreshLabel
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateStyle = kCFDateFormatterMediumStyle;
    formatter.timeStyle = kCFDateFormatterMediumStyle;
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSString *dateString = [formatter stringFromDate:date];
    self.timeLabel.text = dateString;
}

-(void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

/*
 1.必须加入Runloop
 上面不管使用哪种方法，实际最后都会加入RunLoop中执行，区别就在于是否手动加入而已。
 
 
 2.存在延迟
 不管是一次性的还是周期性的timer的实际触发事件的时间，都会与所加入的RunLoop和RunLoop Mode有关，如果此RunLoop正在执行一个连续性的运算，timer就会被延时出发。重复性的timer遇到这种情况，如果延迟超过了一个周期，则会在延时结束后立刻执行，并按照之前指定的周期继续执行，这个延迟时间大概为50-100毫秒.
 所以NSTimer不是绝对准确的,而且中间耗时或阻塞错过下一个点,那么下一个点就pass过去了.
 
 
 3.UIScrollView滑动会暂停计时
 添加到NSDefaultRunLoopMode的 timer 在 UIScrollView滑动时会暂停，若不想被UIScrollView滑动影响，需要将 timer 添加再到 UITrackingRunLoopMode 或 直接添加到NSRunLoopCommonModes 中
 */

@end
