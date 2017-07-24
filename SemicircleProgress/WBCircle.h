//
//  ViewController.m
//  SemicircleProgress
//
//  Created by 王文博 on 2017/7/24.
//  Copyright © 2017年 王文博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBCircle : UIView

-(instancetype)initWithFrame:(CGRect)frame lineWidth:(float)lineWidth;

@property (assign,nonatomic) float progress;

@end
