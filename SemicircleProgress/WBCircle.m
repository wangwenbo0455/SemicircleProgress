//
//  ViewController.m
//  SemicircleProgress
//
//  Created by 王文博 on 2017/7/24.
//  Copyright © 2017年 王文博. All rights reserved.
//

#import "WBCircle.h"
#import "UIColor+FastKit.h"
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
    
    
    CGFloat startAngle = -M_PI*4/4;
    CGFloat endAngle = 0;
    CGFloat  arc = endAngle-startAngle;
    CGFloat perAngle=arc/36;
    
    CGFloat secondLineWigth = _lineWidth;//  线的长度，修改这个 需修改lineradius  酌情修改
    
    for (NSInteger i = 0; i<= 36; i++) {
        CGFloat startAngel = (startAngle+ perAngle * i);
        CGFloat endAngel   = startAngel + perAngle/10;//  这里改宽度的比例，
        float lineradius = radius-secondLineWigth;
        UIBezierPath *tickPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:lineradius startAngle:startAngel endAngle:endAngel clockwise:YES];
        CAShapeLayer *perLayer = [CAShapeLayer layer];
        perLayer.strokeColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
        perLayer.lineWidth   = secondLineWigth;
        perLayer.path = tickPath.CGPath;
        [self.layer addSublayer:perLayer];
    }
    
    
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
    [gradientLayer setColors:@[(id)[UIColor colorWithHexString:@"#137eff"].CGColor,
                               (id)[UIColor colorWithHexString:@"#9200ff"].CGColor,(id)[UIColor colorWithHexString:@"#f50b38"].CGColor]];    //   渐变的颜色数组   自己填写
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
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
//    float Leftradius = (self.bounds.size.width-_lineWidth)/2.0;
//    float x = 0,y = 0;
    
    CGFloat angle = M_PI*0.01;//  这里改初始位置，数值为 0---0.5  超0.5需另做处理
    float Leftradius = (self.bounds.size.width-_lineWidth)/2.0;
    int index = (angle)/M_PI_2;
    float needAngle = angle - index*M_PI_2;
    float x = 0,y = 0;
    x = Leftradius - cosf(needAngle)*Leftradius;
    y = Leftradius - sinf(needAngle)*Leftradius;
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


- (void)drawInContext:(CGContextRef)contextRef
{
    
}


@end
