//
//  ControlPoint.m
//  FlatKnobTest
//
//  Created by Paolo Boschini on 9/18/13.
//  Copyright (c) 2013 Paolo Boschini. All rights reserved.
//

#import "ControlPoint.h"
#import "FlatKnob.h"

@interface ControlPoint ()
{
    float currentDraggedAngle;
    int currentAngle;
    int mouseDownPosition;
    int previousValue;
    int value;
    int insets;
    int controlPointDiameter;
    NSColor *controlPointColor;
}
@end

@implementation ControlPoint

- (id)initWithFrame:(NSRect)frame withInsets:(int)_insets
                    withControlPointDiameter:(int)_controlPointDiameter
                       withControlPointColor:(NSColor*)_controlPointColor
{
    self = [super initWithFrame:frame];
    if (self)
    {
        insets = _insets;
        controlPointDiameter = _controlPointDiameter;
        controlPointColor = _controlPointColor;
        currentDraggedAngle = currentAngle = 225;
        previousValue = 0;
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSBezierPath *indicator;
    [[controlPointColor colorWithAlphaComponent:1] set];
    indicator = [NSBezierPath bezierPathWithOvalInRect:[self makeRectWithWidth:controlPointDiameter]];
    [indicator fill];
    
    [[controlPointColor colorWithAlphaComponent:0.5] set];
    indicator = [NSBezierPath bezierPathWithOvalInRect:[self makeRectWithWidth:controlPointDiameter+2]];
    [indicator fill];
    
    [[controlPointColor colorWithAlphaComponent:0.3] set];
    indicator = [NSBezierPath bezierPathWithOvalInRect:[self makeRectWithWidth:controlPointDiameter+4]];
    [indicator fill];
}

- (NSRect)makeRectWithWidth:(int)width
{
    double radians = currentDraggedAngle * M_PI / 180.0;
    int radius = (self.bounds.size.width/2 - insets);
    return NSMakeRect(cos(radians)*radius + self.bounds.size.width/2 - width/2,
                      sin(radians)*radius + self.bounds.size.height/2 - width/2,
                      width,
                      width);
}

#pragma mark Control
- (void)mouseDown:(NSEvent *)theEvent
{
    NSPoint event_location = [theEvent locationInWindow];
    NSPoint local_point = [self convertPoint:event_location fromView:nil];
    mouseDownPosition = (int)local_point.y;
}

- (void)mouseUp:(NSEvent *)theEvent
{
    currentAngle = currentDraggedAngle;
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    [self updateWithYcoord:theEvent];
}

- (void)updateWithYcoord:(NSEvent *)theEvent
{
    NSPoint event_location = [theEvent locationInWindow];
    NSPoint local_point = [self convertPoint:event_location fromView:nil];
    currentDraggedAngle = mouseDownPosition - (int)local_point.y + currentAngle;
    
    if (currentDraggedAngle > 225) currentDraggedAngle = 225;
    if (currentDraggedAngle < -45) currentDraggedAngle = -45;
    
    float currentValuePosition = (225.0 - currentDraggedAngle);
    value = (currentValuePosition / 270.0) * (self.data.count-1);
    
    if (value != previousValue)
    {
        previousValue = value;

        [self.delegate knobUpdatedWithIndex:value
                                  withValue:[self.data objectAtIndex:value]
                                 withObject:self.superview];
         
        currentDraggedAngle = 225.0 - ((270.0 / (self.data.count-1)) * value);
        [self setNeedsDisplay:YES];
    }
}

- (BOOL)mouseDownCanMoveWindow
{
    return NO;
}

@end