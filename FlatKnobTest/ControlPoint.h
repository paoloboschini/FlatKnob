//
//  ControlPoint.h
//  FlatKnobTest
//
//  Created by Paolo Boschini on 9/18/13.
//  Copyright (c) 2013 Paolo Boschini. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FlatKnob.h"

@interface ControlPoint : NSView

@property NSArray *data;
@property (weak) id <FlatKnobProtocol> delegate;

- (id)initWithFrame:(NSRect)frame withInsets:(int)insets
                    withControlPointDiameter:(int)controlPointDiameter
                       withControlPointColor:(NSColor*)controlPointColor;

@end
