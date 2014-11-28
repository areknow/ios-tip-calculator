//
//  sliderControl.m
//  tipCalc
//
//  Created by Arnaud Crowther on 12/5/13.
//  Copyright (c) 2013 Arnaud Crowther. All rights reserved.
//

#import "sliderControl.h"

@implementation sliderControl

#define SIZE_EXTENSION_Y -11

- (BOOL) pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, 0, SIZE_EXTENSION_Y);
    return CGRectContainsPoint(bounds, point);
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}




@end
