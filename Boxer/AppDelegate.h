//
//  AppDelegate.h
//  Boxer
//
//  Created by William Bajzek on 3/5/13.
//  Copyright (c) 2013 William Bajzek. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *countdown;
@property (weak) IBOutlet NSPopUpButton *amount;
@property (weak) IBOutlet NSButton *goButton;
@property BOOL running;
@property (weak) NSTimer *timer;
- (IBAction)go:(NSButton *)sender;
- (IBAction)timeChanged:(id)sender;

@end
