//
//  FlatKnob.h
//  FlatKnobTest
//
//  Created by Paolo Boschini on 9/18/13.
//  Copyright (c) 2013 Paolo Boschini. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class ControlPoint;

static const int INSETS = 10;
static const int CONTROL_POINT_DIAMETER = 12;

@protocol FlatKnobProtocol <NSObject>
- (void)knobUpdatedWithIndex:(int)index
                   withValue:(id)value
                  withObject:(id)knob;
@end

@interface FlatKnob : NSView

@property int control;
@property ControlPoint *controlPoint;

- (id)initWithFrame:(NSRect)frame
               withInsets:(int)insets
 withControlPointDiameter:(int)controlPointDiameter
    withControlPointColor:(NSColor*)controlPointColor
            withKnobColor:(NSColor*)knobColor
      withBackgroundColor:(NSColor*)backgroundColor;

@end