//
//  ColorUtils.m
//  ColorTeller
//
//  Created by Le Yu on 8/5/14.
//  Copyright (c) 2014 Le Yu. All rights reserved.
//

#import "ColorUtils.h"

@implementation ColorUtils

#pragma mark Color

+ (UIColor *)redColor
{
    // return [UIColor colorWithRed:234.0/255.0 green:89.0/255.0 blue:110.0/255.0 alpha:1]; // Light red
    return [UIColor colorWithRed:244/255.0 green:171/255.0 blue:186/255.0 alpha:1]; // Faded red
}

+ (UIColor *)blueColor
{
    // return [UIColor colorWithRed:136.0/255.0 green:201.0/255.0 blue:249.0/255.0 alpha:1]; // Light Blue
    return [UIColor colorWithRed:80/255.0 green:165.0/255.0 blue:230.0/255.0 alpha:1]; // Medium
}

+ (UIColor *)greenColor
{
    // return [UIColor colorWithRed:166.0/255.0 green:211.0/255.0 blue:136.0/255.0 alpha:1];
    // return [UIColor colorWithRed:119/255.0 green:178.0/255.0 blue:85.0/255.0 alpha:1]; // Medium
    return [UIColor colorWithRed:62/255.0 green:114.0/255.0 blue:29.0/255.0 alpha:1]; // Dark Green
    // return [UIColor colorWithRed:92/255.0 green:145.0/255.0 blue:59.0/255.0 alpha:1]; // Deep Green
}

+ (UIColor *)yellowColor
{
    return [UIColor colorWithRed:255.0/255.0 green:217.0/255.0 blue:131.0/255.0 alpha:1];
}


+ (NSArray *) validColorNames
{
    return @[@"PINK", @"BLUE", @"GREEN", @"YELLOW"];
}

+ (NSArray *) validColors
{
    return @[[ColorUtils redColor], [ColorUtils blueColor], [ColorUtils greenColor], [ColorUtils yellowColor]];
}

+ (NSString *)randomColorText
{
    NSArray *colors = [ColorUtils validColorNames];
    NSUInteger colorCount = [colors count];
    NSUInteger colorIndex = [ColorUtils randomIndex:colorCount];
    return colors[colorIndex];
}

+ (UIColor *)randomColor:(NSArray *)colors
{
    NSUInteger colorCount = [colors count];
    NSUInteger colorIndex = [ColorUtils randomIndex:colorCount];
    return colors[colorIndex];
}

+ (NSUInteger)randomIndex:(NSUInteger)colorCount
{
    return arc4random() % colorCount;
}

#pragma mark Score
#define Score @"ColorTeller.score"
#define HighestScore @"ColorTeller.highestScore"


+ (void)saveHighestScore:(NSInteger)score
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setInteger:score forKey:HighestScore];
}

+ (NSInteger)getHighestScore
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger score = [standardUserDefaults integerForKey:HighestScore];
    return score;
}


@end
