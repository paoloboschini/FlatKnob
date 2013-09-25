//
//  AppDelegate.h
//  FlatKnobTest
//
//  Created by Paolo Boschini on 9/18/13.
//  Copyright (c) 2013 Paolo Boschini. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FlatKnob.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, FlatKnobProtocol>

@property (assign) IBOutlet NSWindow *window;

@end
