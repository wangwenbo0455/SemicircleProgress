//
//  NSTimer+FastKit.m
//  FastKitDemo
//
//  Created by 李新星 on 16/2/16.
//  Copyright © 2016年 xx-li. All rights reserved.
//

#import "NSTimer+FastKit.h"

NSString * const kUserInfoKey = @"userInfo";
NSString * const kBlockKey = @"block";


@interface FKWeakTimerTarget : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer* timer;

@end

@implementation FKWeakTimerTarget

- (void) fire:(NSTimer *)timer {
    if(self.target) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:timer afterDelay:0.0f];
#pragma clang diagnostic pop
    } else {
        [self.timer invalidate];
    }
}

@end

@implementation NSTimer (FastKit)

+ (NSTimer *) fk_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)repeats {
    
    FKWeakTimerTarget* timerTarget = [[FKWeakTimerTarget alloc] init];
    timerTarget.target = aTarget;
    timerTarget.selector = aSelector;
    timerTarget.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                         target:timerTarget
                                                       selector:@selector(fire:)
                                                       userInfo:userInfo
                                                        repeats:repeats];
    return timerTarget.timer;
    
}

+ (NSTimer *)fk_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(FKTimerHandler)block
                                      userInfo:(id)userInfo
                                       repeats:(BOOL)repeats {
    NSMutableDictionary * infoDic = [NSMutableDictionary dictionary];
    if (block) {
        [infoDic setObject:[block copy] forKey:kBlockKey];
    }
    if (userInfo) {
        [infoDic setObject:userInfo forKey:kUserInfoKey];
    }
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(fk_timerBlockInvoke:)
                                       userInfo:infoDic
                                        repeats:repeats];
}

+ (void)fk_timerBlockInvoke:(NSTimer*)timer {
    NSDictionary * userInfo = timer.userInfo;
    FKTimerHandler block = [userInfo objectForKey:kBlockKey];
    id info = [userInfo objectForKey:kUserInfoKey];
    if (block) {
        block(info);
    }
}


@end
