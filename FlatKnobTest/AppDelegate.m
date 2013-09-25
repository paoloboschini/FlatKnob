//
//  AppDelegate.m
//  FlatKnobTest
//
//  Created by Paolo Boschini on 9/18/13.
//  Copyright (c) 2013 Paolo Boschini. All rights reserved.
//

#import "AppDelegate.h"
#import "FlatKnob.h"
#import "ControlPoint.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
//    [self createKnob];
//    OR
    [self createKnobs];
}

// Called upon a knob update
- (void)knobUpdatedWithIndex:(int)index
                   withValue:(id)value
                  withObject:(id)object
{
    int controlNumber = ((FlatKnob*)object).control;
    NSLog(@"Knob index: %d" , index);
    NSLog(@"Knob value: %@" , value);
    NSLog(@"Knob control: %d" , controlNumber);
    NSLog(@"\n");
    
    // Get labels
    NSMutableArray *subViews = [NSMutableArray arrayWithArray:[self.window.contentView subviews]];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"self isKindOfClass: %@", [NSTextField class]];
    NSArray *textFields = [subViews filteredArrayUsingPredicate:p];

    // update appropriate label
    [[textFields objectAtIndex:controlNumber] setStringValue:[NSString stringWithFormat:@"Value: %@", value]];
}

// Helper method to create a knob
- (void)createKnob
{
    // Use this constructor to instantiate a "default" look FlatKnob
    FlatKnob *knob = [[FlatKnob alloc] initWithFrame:NSMakeRect(10, 30, 100, 100)];
    
    // Set the knob's id
    knob.control = 0;
    
    // Set the knob's delegate (implements knobUpdatedWithIndex...)
    knob.controlPoint.delegate = self;
    
    // Set a datasource for the knob (max range: 0..269)
//    knob.controlPoint.data = @[@"a", @"b", @"c", @"d"];
    knob.controlPoint.data = [self generateArrayFrom:0 to:100];
    
    // Add knob to window
    [self.window.contentView addSubview:knob];
    
    // Add label to window
    NSTextField* label = [self createLabelWithFrame:NSMakeRect(10, 10, 100, 17)];
    [self.window.contentView addSubview:label];
}

// Helper method to create knobs
- (void)createKnobs
{
    NSArray *colorArray = @[@"#ccee00", @"#74c7b9", @"#064650",
                            @"#f15b40", @"#67abb8", @"#262626",
                            @"#ffffbb", @"#773300", @"#118899",
                            @"#991111", @"#ffffee", @"#004477"];
    
    for (int i = 0; i < 4; ++i)
    {
        // Use this designated constructor to instantiate a custom FlatKnob
        FlatKnob *knob = [[FlatKnob alloc] initWithFrame:NSMakeRect(i*100 + i*10 + 10, 30, 100, 100)
                                              withInsets:10
                                withControlPointDiameter:10
                                   withControlPointColor:[self colorFromHexString:[colorArray objectAtIndex:i*3]]
                                           withKnobColor:[self colorFromHexString:[colorArray objectAtIndex:i*3+1]]
                                     withBackgroundColor:[self colorFromHexString:[colorArray objectAtIndex:i*3+2]]];
        
        // Set the knob's id
        knob.control = i;
        
        // Set the knob's delegate (implements knobUpdatedWithIndex...)
        knob.controlPoint.delegate = self;
        
        // Set a datasource for the knob (max range: 0..269)
//        knob.controlPoint.data = @[@"a", @"b", @"c", @"d"];
        knob.controlPoint.data = [self generateArrayFrom:0 to:100];
        
        // Add knob to window
        [self.window.contentView addSubview:knob];
        
        // Add label to window
        NSTextField* label = [self createLabelWithFrame:NSMakeRect(i*100 + i*10 + 10, 10, 100, 17)];
        [self.window.contentView addSubview:label];
    }
}

// Helper method to create a label
- (NSTextField*)createLabelWithFrame:(NSRect)frame
{
    NSTextField *label = [[NSTextField alloc] initWithFrame:frame];
    [label setStringValue:@"Value: -"];
    [label setBezeled:NO];
    [label setDrawsBackground:NO];
    [label setEditable:NO];
    [label setSelectable:NO];
    [label setAlignment:NSCenterTextAlignment];
    [label setWantsLayer:YES];
    label.layer.borderWidth = 0;
    label.layer.borderColor = [NSColor blackColor].CGColor;
    return label;
}

// Helper method to generate an array
- (NSArray*)generateArrayFrom:(int)start to:(int)stop
{
    NSMutableArray *a = [[NSMutableArray alloc] init];
    for (int i = start; i < stop; ++i)
        [a addObject:@(i)];
    return a;
}

// Helper method from hex string to NSColor
- (NSColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return[NSColor colorWithSRGBRed:((rgbValue & 0xFF0000) >> 16)/255.0
                              green:((rgbValue & 0xFF00) >> 8)/255.0
                               blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end