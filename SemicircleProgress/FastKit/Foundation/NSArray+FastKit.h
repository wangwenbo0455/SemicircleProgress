//
//  NSMutableArray+FastKit.h
//  FastKitDemo
//
//  Created by 李新星 on 15/11/27.
//  Copyright © 2015年 xx-li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FastKit)

/**
 Returns the object located at a random index.
 
 @return The object in the array with a random index value.
 If the array is empty, returns nil.
 */
- (id)randomObject;

/**
 Returns the object located at index, or return nil when out of bounds.
 It's similar to `objectAtIndex:`, but it never throw exception.
 
 @param index The object located at index.
 */
- (id)objectOrNilAtIndex:(NSUInteger)index;

/**
 Convert object to json string. return nil if an error occurs.
 NSString/NSNumber/NSDictionary/NSArray
 */
- (NSString *)jsonStringEncoded;

/**
 Convert object to json string formatted. return nil if an error occurs.
 */
- (NSString *)jsonPrettyStringEncoded;


/**
 *  Convert the given array to JSON as NSString
 *
 *  @param array The array to be reversed
 *
 *  @return Return the JSON as NSString or nil if error while parsing
 */
+ (NSArray *)reversedArray:(NSArray *)array;

- (NSArray *)reversedArray;

/**
 *  Get the object at a given index in safe mode (nil if self is empty)
 *
 *  @param index The index
 *
 *  @return Return the object at a given index in safe mode (nil if self is empty)
 */
- (id)safeObjectAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (FastKit)

/**
 Reverse the index of object in this array.
 Example: Before @[ @1, @2, @3 ], After @[ @3, @2, @1 ].
 */
- (void)reverse;

/**
 Sort the object in this array randomly.
 */
- (void)shuffle;


/*! object为nil,则返回NO。 非nil，则返回Yes，添加OK */
- (BOOL)saftyAddObject:(id)object;




@end

