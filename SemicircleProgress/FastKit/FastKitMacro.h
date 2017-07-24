//
//  FastKitMacro.h
//  FastKitDemo
//
//  Created by 李新星 on 15/11/27.
//  Copyright © 2015年 xx-li. All rights reserved.
//

#ifndef FastKitMacro_h
#define FastKitMacro_h

#import "CGUtilities.h"

/**
 *  Get App name
 */
#ifndef APP_NAME
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#endif

/**
 *  Get App build
 */
#ifndef APP_BUILD
#define APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#endif

/**
 *  Get App version
 */
#ifndef APP_VERSION
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#endif


#ifndef SWAP // swap two value
#define SWAP(_a_, _b_)  do { __typeof__(_a_) _tmp_ = (_a_); (_a_) = (_b_); (_b_) = _tmp_; } while (0)
#endif

// main screen's scale
#ifndef kScreenScale
#define kScreenScale FScreenScale()
#endif

// main screen's size (portrait)
#ifndef kScreenSize
#define kScreenSize FScreenSize()
#endif

// main screen's width (portrait)
#ifndef kScreenWidth
#define kScreenWidth FScreenSize().width
#endif

// main screen's height (portrait)
#ifndef kScreenHeight
#define kScreenHeight FScreenSize().height
#endif

#endif /* FastKitMacro_h */
