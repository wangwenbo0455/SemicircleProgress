//
//  NSDictionary+FastKit.h
//  FastKitDemo
//
//  Created by 李新星 on 15/11/27.
//  Copyright © 2015年 xx-li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FastKit)

/*! 如果为NSNull,转换为nil返回 */
- (id)objectNotNullForKey:(id)key;

/**
 Convert dictionary to json string. return nil if an error occurs.
 */
- (NSString *)jsonStringEncoded;

/**
 Convert dictionary to json string formatted. return nil if an error occurs.
 */
- (NSString *)jsonPrettyStringEncoded;


@end
