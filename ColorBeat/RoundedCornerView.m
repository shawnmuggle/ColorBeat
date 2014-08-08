//
//  RoundedCornerView.m
//  ColorBeat
//
//  Created by Le Yu on 8/7/14.
//  Copyright (c) 2014 Le Yu. All rights reserved.
//

#import "RoundedCornerView.h"

@implementation RoundedCornerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder;
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    CALayer *layer = self.layer;
    layer.cornerRadius  = 10.0f;
    layer.masksToBounds = YES;
}


@end
