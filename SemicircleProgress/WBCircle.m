//
//  ViewController.m
//  SemicircleProgress
//
//  Created by 王文博 on 2017/7/24.
//  Copyright © 2017年 王文博. All rights reserved.
//

#import "WBCircle.h"
#define CircleDegreeToRadian(d) ((d)*M_PI)/180.0

static CGFloat endPointMargin = 1.0f;

@interface WBCircle ()
{
    CAShapeLayer* _trackLayer;
    CAShapeLayer* _progressLayer;
    UIImageView* _endPoint;//在终点位置添加一个点
    CGFloat _lineWidth;
}
@end

@implementation WBCircle

-(instancetype)initWithFrame:(CGRect)frame lineWidth:(float)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineWidth = lineWidth;
        [self buildLayout];
    }
    return self;
}

-(void)buildLayout
{
    float centerX = self.bounds.size.width/2.0;
    float centerY = self.bounds.size.height/2.0;
    float radius = (self.bounds.size.width-_lineWidth)/2.0;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:-CircleDegreeToRadian(-180) endAngle:CircleDegreeToRadian(0) clockwise:YES];
    CAShapeLayer *backLayer = [CAShapeLayer layer];
    backLayer.frame = self.bounds;
    backLayer.fillColor =  [[UIColor clearColor] CGColor];
    backLayer.strokeColor  = [UIColor lightGrayColor].CGColor;//  背景的颜色自行更改
    backLayer.lineWidth = _lineWidth;
    backLayer.lineCap = kCALineCapRound;
    backLayer.path = [path CGPath];
    backLayer.strokeEnd = 1;
    [self.layer addSublayer:backLayer];
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];// 填充色 不要改
    _progressLayer.strokeColor  = [[UIColor yellowColor] CGColor];//  边框颜色  随便改，但是不能删
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = _lineWidth;
    _progressLayer.path = [path CGPath];
    _progressLayer.strokeEnd = 0;
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    [gradientLayer setColors:@[(id)[UIColor purpleColor].CGColor,
                               (id)[UIColor redColor].CGColor]];    //   渐变的颜色数组   自己填写
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    [gradientLayer setMask:_progressLayer];
    [self.layer addSublayer:gradientLayer];
    
    //用于显示结束位置的小点
    _endPoint = [[UIImageView alloc] init];
    _endPoint.frame = CGRectMake(0, 0, _lineWidth - endPointMargin*2,_lineWidth - endPointMargin*2);
    _endPoint.backgroundColor = [UIColor whiteColor];
    _endPoint.layer.masksToBounds = true;
    _endPoint.layer.cornerRadius = _endPoint.bounds.size.width/2;
    [self addSubview:_endPoint];

    //用于显示起始位置的小点
    UIImageView * startPoint = [[UIImageView alloc] init];
    startPoint.frame = CGRectMake(0, 0, _lineWidth - endPointMargin*2,_lineWidth - endPointMargin*2);
    startPoint.backgroundColor = [UIColor whiteColor];
    startPoint.layer.masksToBounds = true;
    startPoint.layer.cornerRadius = startPoint.bounds.size.width/2;
    [self addSubview:startPoint];
    float Leftradius = (self.bounds.size.width-_lineWidth)/2.0;
    float x = 0,y = 0;
    x = Leftradius - cosf(0.0)*Leftradius;
    y = Leftradius - sinf(0.0)*Leftradius;
    CGRect rect = startPoint.frame;
    rect.origin.x = x + endPointMargin;
    rect.origin.y = y + endPointMargin;
    startPoint.frame = rect;
    [self bringSubviewToFront:startPoint];
}

-(void)setProgress:(float)progress
{
    _progress = progress;
    _progressLayer.strokeEnd = progress;
    [self updateEndPoint];
    [_progressLayer removeAllAnimations];
}



-(void)updateEndPoint
{
    CGFloat angle = M_PI*_progress;
    float radius = (self.bounds.size.width-_lineWidth)/2.0;
    int index = (angle)/M_PI_2;
    float needAngle = angle - index*M_PI_2;
    float x = 0,y = 0;
    switch (index) {
        case 0:
            x = radius - cosf(needAngle)*radius;
            y = radius - sinf(needAngle)*radius;
            break;
        case 1:
             x = radius + sinf(needAngle)*radius;
            y = radius - cosf(needAngle)*radius;
            break;
        case 2:
             x = radius + cosf(needAngle)*radius;
            y = radius + sinf(needAngle)*radius;
            break;
        case 3:
            break;
        default:
            break;
    }
    CGRect rect = _endPoint.frame;
    rect.origin.x = x + endPointMargin;
    rect.origin.y = y + endPointMargin;
    _endPoint.frame = rect;
    [self bringSubviewToFront:_endPoint];
}

@end
