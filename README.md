FlatKnob
========

Flat Customizable Circular Knob

![alt tag](https://raw.github.com/paoloboschini/FlatKnob/master/screen.png)

Features
========

* Cusomizable appearance
* Cusomizable value range

Basic Usage
========

See example project for a demo.

```objectivec
// create a knob
FlatKnob *knob = [[FlatKnob alloc] initWithFrame:NSMakeRect(10, 30, 100, 100)];

// or a custom knob
FlatKnob *knob = [[FlatKnob alloc] initWithFrame:NSMakeRect(10, 30, 100, 100)
                                      withInsets:10
                        withControlPointDiameter:10
                           withControlPointColor:[NSColor whiteColor]
                                   withKnobColor:[NSColor blackColor]
                             withBackgroundColor:[NSColor redColor]];

    
// Set the knob's id
knob.control = 0;
    
// Set the knob's delegate (must conform to FlatKnobProtocol and implement knobUpdatedWithIndex...)
knob.controlPoint.delegate = self;
    
// Set a datasource for the knob (max range: 0..269) passing an array of values
knob.controlPoint.data = @[@"a", @"b", @"c", @"d"];

// Add knob to window
[self.window.contentView addSubview:knob];

...

// Called upon a knob update
- (void)knobUpdatedWithIndex:(int)index
                   withValue:(id)value
                  withObject:(id)object
{
    int controlNumber = ((FlatKnob*)object).control;
    NSLog(@"Knob index: %d" , index);
    NSLog(@"Knob value: %@" , value);
    NSLog(@"Knob control: %d" , controlNumber);
}

```
