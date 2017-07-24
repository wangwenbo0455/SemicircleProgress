//
//  UILabel+FastKit.m
//  FastKitDemo
//
//  Created by 李新星 on 15/11/27.
//  Copyright © 2015年 xx-li. All rights reserved.
//

#import "UILabel+FastKit.h"

@implementation UILabel (FastKit)

-(void)setText:(NSString *)text font:(UIFont *)font color:(UIColor *)color {
    self.text = text;
    self.font = font;
    self.textColor = color;
}

-(void)setKeyWords:(NSArray *)keyWords font:(UIFont *)keyWordfont color:(UIColor *)keyWordColor {
    
    if (keyWords == nil) {
        return;
    }
    
    UIFont * currentFont = nil;
    if (keyWordfont == nil) {
        currentFont = self.font;
    } else {
        currentFont = keyWordfont;
    }
    
    UIColor * currentColor = nil;
    if (keyWordColor == nil) {
        currentColor = self.textColor;
    } else {
        currentColor = keyWordColor;
    }
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    NSMutableArray *rangeArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [keyWords count]; i++) {
        NSString *keyString = [keyWords objectAtIndex:i];
        NSRange range = [self.text rangeOfString:keyString];
        NSValue *value = [NSValue valueWithRange:range];
        if (range.length > 0) {
            [rangeArray addObject:value];
        }
    }
    
    for (NSValue *value in rangeArray) {
        NSRange keyRange = [value rangeValue];
        [attributedString addAttribute:NSForegroundColorAttributeName value:currentColor range:keyRange];
        [attributedString addAttribute:NSFontAttributeName value:currentFont range:keyRange];
    }
    self.attributedText = attributedString;

    
}

//动态设置Label的高度
+ (UILabel *)dynamicHeightLabelWithPointX:(CGFloat)pointX
                                   pointY:(CGFloat)pointY
                                    width:(CGFloat)width
                               strContent:(NSString *)strContent
                                    color:(UIColor *)color
                                     font:(UIFont *)font
                            textAlignmeng:(NSTextAlignment)textAlignmeng
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [strContent boundingRectWithSize:CGSizeMake(width,MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:attributes
                                                context:nil].size;
    
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(pointX, pointY, width, labelSize.height)];
    [myLabel setNumberOfLines:0];
    myLabel.text = strContent;
    myLabel.font = font;
    myLabel.textColor = color;
    return myLabel;
    
}

@end
