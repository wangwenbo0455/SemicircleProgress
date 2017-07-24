//
//  UILabel+FastKit.h
//  FastKitDemo
//
//  Created by 李新星 on 15/11/27.
//  Copyright © 2015年 xx-li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FastKit)

-(void)setText:(NSString *)text
          font:(UIFont *)font
         color:(UIColor *)color;

/**
 *  将关键字设定为制定的颜色和字体
 *
 *  @param keyWords     关键字列表
 *  @param keyWordfont  字体
 *  @param keyWordColor 颜色
 */
-(void)setKeyWords:(NSArray *)keyWords
              font:(UIFont *)keyWordfont
             color:(UIColor *)keyWordColor;

/**
 *  创建一个动态高度的UILabel
 *
 *  @param pointX        Label的横坐标
 *  @param pointY        Label的纵坐标
 *  @param width         Label的宽度
 *  @param strContent    内容
 *  @param color         字体颜色
 *  @param font          字体大小
 *  @param textAlignmeng 对齐方式
 *
 *  @return 返回一个UILabel
 */
+ (UILabel *)dynamicHeightLabelWithPointX:(CGFloat)pointX
                                   pointY:(CGFloat)pointY
                                    width:(CGFloat)width
                               strContent:(NSString *)strContent
                                    color:(UIColor *)color
                                     font:(UIFont *)font
                            textAlignmeng:(NSTextAlignment)textAlignmeng;

@end
