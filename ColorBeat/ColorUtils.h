//
//  ColorUtils.h
//  ColorTeller
//
//  Created by Le Yu on 8/5/14.
//  Copyright (c) 2014 Le Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorUtils : NSObject

+ (UIColor *)redColor;
+ (UIColor *)blueColor;
+ (UIColor *)greenColor;
+ (UIColor *)yellowColor;


+ (NSArray *) validColorNames;
+ (NSArray *) validColors;
+ (NSString *)randomColorText;
+ (UIColor *)randomColor:(NSArray *)colors;
+ (NSUInteger)randomIndex:(NSUInteger)colorCount;


+ (void)saveHighestScore:(NSInteger)score;
+ (NSInteger)getHighestScore;
@end
