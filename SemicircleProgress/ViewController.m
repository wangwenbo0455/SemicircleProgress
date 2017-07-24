//
//  ViewController.m
//  SemicircleProgress
//
//  Created by 王文博 on 2017/7/24.
//  Copyright © 2017年 王文博. All rights reserved.
//

#import "ViewController.h"
#import "WBCircle.h"
#import "WBCircleProgress.h"
@interface ViewController ()
{
    WBCircle *_circle;
    UIImageView * _firstImageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCircle];

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)addCircle
{
    
    
    
    float lineWidth = 0.1*self.view.bounds.size.width;
    
    CGFloat margin = 15.0f;
    CGFloat circleWidth = [UIScreen mainScreen].bounds.size.width - 2*margin;
    
    
    WBCircleProgress * circle = [[WBCircleProgress alloc]initWithFrame:CGRectMake(0, 0, circleWidth, circleWidth)];
    circle.center = self.view.center;
    circle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:circle];
    
    
    
    _circle = [[WBCircle alloc] initWithFrame:CGRectMake(0, 0, circleWidth, circleWidth) lineWidth:lineWidth];
    _circle.progress = 0;
    _circle.center = self.view.center;
    [self.view addSubview:_circle];
    


    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(_circle.frame) + 50, self.view.bounds.size.width - 2*50, 30)];
    [slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
    [slider setMaximumValue:1];
    [slider setMinimumValue:0];
    [slider setMinimumTrackTintColor:[UIColor colorWithRed:255.0f/255.0f green:151.0f/255.0f blue:0/255.0f alpha:1]];
    [self.view addSubview:slider];
    
    
    _firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 300, 200, 200)];
    [_firstImageView setImage:[UIImage imageNamed:@"11.jpg"]];
    [self startAnimation];
    [self.view addSubview:_firstImageView];
}

- (void)startAnimation {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D rotateTransform = CATransform3DMakeRotation(1.57, 0, 0, -1);
    
    CATransform3D scaleTransform = CATransform3DMakeScale(1.2, 1.2, 1.2);
    //(CGFloat tx,CGFloat ty, CGFloat tz ,x,y,z轴的偏移量
    // CATransform3D positionTransform = CATransform3DMakeTranslation(0, 0, 10); //位置移动
    CATransform3D combinedTransform =CATransform3DConcat(rotateTransform, scaleTransform); //Concat就是combine的意思
    //combinedTransform = CATransform3DConcat(combinedTransform, positionTransform); //再combine一次把三个动作连起来
    
    [anim setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]]; //放在3D坐标系中最正的位置
    [anim setToValue:[NSValue valueWithCATransform3D:combinedTransform]];
    anim.duration = 1.0f;
    anim.autoreverses = YES;
    anim.repeatCount = MAXFLOAT;
    
    [_firstImageView.layer addAnimation:anim forKey:nil];
    
    //[firstImageView.layer setTransform:combinedTransform];  //如果没有这句，layer执行完动画又会返回最初的state
}

-(void)sliderMethod:(UISlider*)slider
{
    _circle.progress = slider.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
