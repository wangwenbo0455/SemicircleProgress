//
//  WBCircleProgress.h
//  SemicircleProgress
//
//  Created by 王文博 on 2017/7/24.
//  Copyright © 2017年 王文博. All rights reserved.
//

#import "WBCircleProgress.h"
#import "UIColor+FastKit.h"
//角度转换为弧度
#define CircleDegreeToRadian(d) ((d)*M_PI)/180.0
@interface WBCircleProgress ()
{
    CGFloat _lineWidth;
}
@end
@implementation WBCircleProgress


//初始化
- (instancetype)initWithFrame:(CGRect)frame lineWidth:(float)lineWidth {
    if (self = [super initWithFrame:frame]) {
        _lineWidth = lineWidth;
    }
    return self;
}


- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(id)[UIColor colorWithHexString:@"#9200ff"].CGColor,
                      (id)[UIColor colorWithHexString:@"#137eff"].CGColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

//画背景线、填充线、小圆点、文字
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat startAngle = -CircleDegreeToRadian(-180);

    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //设置中心点 半径 起点及终点
    CGFloat endA = CircleDegreeToRadian(0);//圆终点位置
    float centerX = self.bounds.size.width/2.0;
    float centerY = self.bounds.size.height/2.0;
    float radius = (self.bounds.size.width-_lineWidth*3)/2.0 ;
    //背景线
    UIBezierPath *basePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:startAngle endAngle:endA clockwise:YES];
    //线条宽度
    CGContextSetLineWidth(ctx, 0);
    //设置线条顶端
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //线条颜色
    [[UIColor clearColor] setStroke];
    //把路径添加到上下文
    CGContextAddPath(ctx, basePath.CGPath);
    //渲染背景线
    CGContextStrokePath(ctx);
    
    //线条颜色
    [self drawLinearGradient:ctx path:basePath.CGPath startColor:[UIColor greenColor].CGColor endColor:[UIColor redColor].CGColor];
    CGContextStrokePath(ctx);

}


@end
