//
//  NSString+FastKit.h
//  FastKitDemo
//
//  Created by 李新星 on 15/11/27.
//  Copyright © 2015年 xx-li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (FastKit)

#pragma mark - Hash
/**
 *  Create a MD5 string from self
 *
 *  @return Return the MD5 NSString from self
 */
- (NSString *)MD5;


#pragma mark - Drawing
/**
 Returns the size of the string if it were rendered with the specified constraints.
 
 @param font          The font to use for computing the string size.
 
 @param size          The maximum acceptable size for the string. This value is
 used to calculate where line breaks and wrapping would occur.
 
 @param lineBreakMode The line break options for computing the size of the string.
 For a list of possible values, see NSLineBreakMode.
 
 @return              The width and height of the resulting string's bounding box.
 These values may be rounded up to the nearest whole number.
 */
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/**
 Returns the width of the string if it were to be rendered with the specified
 font on a single line.
 
 @param font  The font to use for computing the string width.
 
 @return      The width of the resulting string's bounding box. These values may be
 rounded up to the nearest whole number.
 */
- (CGFloat)widthForFont:(UIFont *)font;

/**
 Returns the height of the string if it were rendered with the specified constraints.
 
 @param font   The font to use for computing the string size.
 
 @param width  The maximum acceptable width for the string. This value is used
 to calculate where line breaks and wrapping would occur.
 
 @return       The height of the resulting string's bounding box. These values
 may be rounded up to the nearest whole number.
 */
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;

#pragma mark - Utilities
/**
 *  Check if self has the given substring
 *
 *  @param substring The substring to be searched
 *
 *  @return Return YES if founded, NO if not
 */
- (BOOL)hasString:(NSString *)substring;

/**
 Trim blank characters (space and newline) in head and tail.
 @return the trimmed string.
 */
- (NSString *)stringByTrim ;

/**
 Try to parse this string and returns an `NSNumber`.
 @return Returns an `NSNumber` if parse succeed, or nil if an error occurs.
 */
- (NSNumber *)numberValue;

#pragma mark - validation
/**
 *  Check if self is an email
 *
 *  @return Return YES if it's an email, NO if not
 */
- (BOOL)isEmail;
+ (BOOL)isEmail:(NSString *)email;

/*! Check if self is an Mobile Phone Number */
- (BOOL)isMobilePhone;
+ (BOOL)isMobilePhone:(NSString*)phone;

/*! Check if self is an Password */
- (BOOL)isPassword;
+ (BOOL)isPassword:(NSString *)pw;

/*! Check if self is an SMS Auth code */
- (BOOL)isAuthCode;
+ (BOOL)isAuthCode:(NSString *)authCode;

/*! Check if self is an BankCard */
- (BOOL)isBankCardNo;
+ (BOOL)isBankCardNo:(NSString *)carNo;

/*! Check if self is an PersonIDCard */
- (BOOL)isPersonIDCardNo;
+ (BOOL)isPersonIDCardNo:(NSString *)idCard;


@end
