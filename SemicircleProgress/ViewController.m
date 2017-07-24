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
