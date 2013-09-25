//
//  FlatKnob.m
//  FlatKnobTest
//
//  Created by Paolo Boschini on 9/18/13.
//  Copyright (c) 2013 Paolo Boschini. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "FlatKnob.h"
#import "ControlPoint.h"

@interface FlatKnob ()
{
    int insets;
    NSColor *backgroundColor;
    NSColor *knobColor;
}
@end

@implementation FlatKnob

// Custom initializer
- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:(CGRect)frame
                    withInsets:INSETS
      withControlPointDiameter:CONTROL_POINT_DIAMETER
         withControlPointColor:[NSColor redColor]
                 withKnobColor:[NSColor colorWithSRGBRed:0 green:0.4 blue:1 alpha:1]
           withBackgroundColor:[NSColor blackColor]];
}

// Designated initializer
- (id)initWithFrame:(NSRect)frame withInsets:(int)_insets
                    withControlPointDiameter:(int)_controlPointDiameter
                       withControlPointColor:(NSColor*)_controlPointColor
                               withKnobColor:(NSColor*)_knobColor
                         withBackgroundColor:(NSColor*)_backgroundColor
{
    self = [super initWithFrame:frame];
    if (self)
    {
        backgroundColor = _backgroundColor;
        knobColor = _knobColor;
        insets = _insets;
        
        [self setWantsLayer:YES];
        self.layer.backgroundColor = backgroundColor.CGColor;
        self.layer.cornerRadius = 15;
        
        NSRect rect = NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height);
        self.controlPoint = [[ControlPoint alloc] initWithFrame:rect
                                                     withInsets:insets
                                       withControlPointDiameter:_controlPointDiameter
                                          withControlPointColor:_controlPointColor];
        [self addSubview:self.controlPoint];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSBezierPath *fillCircle;
    NSRect rect;

    int i;
    for (i = 0; i < 5; ++i)
    {
        rect = NSMakeRect(insets+i,
                          insets+i,
                          self.bounds.size.width - (insets*2 + i*2),
                          self.bounds.size.height - (insets*2 + i*2));
        fillCircle = [NSBezierPath bezierPathWithOvalInRect:rect];
        [[knobColor colorWithAlphaComponent:i * 0.1 + 0.3] setFill];
        [fillCircle fill];
    }
    
    rect = NSMakeRect(insets+i,
                      insets+i,
                      self.bounds.size.width - (insets*2 + i*2),
                      self.bounds.size.height - (insets*2 + i*2));
    fillCircle = [NSBezierPath bezierPathWithOvalInRect:rect];
    [[knobColor colorWithAlphaComponent:1] setFill];
    [fillCircle fill];
}

@end