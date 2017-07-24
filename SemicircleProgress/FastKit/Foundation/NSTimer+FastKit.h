//
//  NSTimer+FastKit.h
//  FastKitDemo
//
//  Created by 李新星 on 16/2/16.
//  Copyright © 2016年 xx-li. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FKTimerHandler)(id userInfo);

@interface NSTimer (FastKit)

+ (NSTimer *) fk_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats;

+ (NSTimer *)fk_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(FKTimerHandler)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats;

@end
