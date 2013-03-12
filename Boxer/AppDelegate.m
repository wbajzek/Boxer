//
//  AppDelegate.m
//  Boxer
//
//  Created by William Bajzek on 3/5/13.
//  Copyright (c) 2013 William Bajzek. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDeledate
-(void)count:(NSDate *)end;
@end

@implementation AppDelegate

@synthesize amount;
@synthesize countdown;
@synthesize running;
@synthesize goButton;

NSTimer *currentTimer;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    running = NO;
    currentTimer = nil;
}

- (IBAction)go:(NSButton *)sender {
    NSTimer *timer;
    if (!running) {
        if ([countdown.stringValue isEqualToString:@"00:00"]) {
            NSDate *end = [NSDate dateWithTimeIntervalSinceNow:(60*[amount.titleOfSelectedItem integerValue])+1];
            timer = [NSTimer timerWithTimeInterval:.5 target:self selector:@selector(count:) userInfo:end repeats:YES];
        }
        else {
            int minutes = [[countdown.stringValue substringToIndex:3] intValue] ;
            int seconds = [[countdown.stringValue substringFromIndex:3] intValue];
            NSDate *end = [NSDate dateWithTimeIntervalSinceNow:(60*minutes) + seconds];
            timer = [NSTimer timerWithTimeInterval:.5 target:self selector:@selector(count:) userInfo:end repeats:YES];
        }
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        currentTimer = timer;
        [timer fire];
        running = YES;
        sender.title = @"Stop";
    }
    else {
        [currentTimer invalidate];
        currentTimer = nil;
        running = NO;
        sender.title = @"Go!";
    }
}

- (IBAction)timeChanged:(id)sender {
    running = NO;
    goButton.title = @"Go!";
    NSString *minutes = [self lpad:amount.titleOfSelectedItem ];
    NSString *seconds = @"00";
    countdown.stringValue = [NSString stringWithFormat:@"%@:%@",minutes,seconds];
    if (currentTimer != nil)
        [currentTimer invalidate];
    
}

-(void)count:(NSTimer *)timer {
    NSDate *end = timer.userInfo;
    int time = [end timeIntervalSinceNow];
    NSString *minutes = [self lpad:[NSString stringWithFormat:@"%d",time/60]];
    NSString *seconds = [self lpad:[NSString stringWithFormat:@"%d",time%60]];
    
    [countdown setStringValue:[NSString stringWithFormat:@"%@:%@",minutes,seconds]];
    if (time == 0) {
        [timer invalidate];
        currentTimer = nil;
        running = NO;
        goButton.title = @"Go!";
        [self notifyDone];
    }
}

-(void)notifyDone {
    
    [NSThread detachNewThreadSelector:@selector(alarm) toTarget:self withObject:nil];
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"Boxer says \"time's up\"";
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    
}

-(void)alarm {
    NSSound *beep = [NSSound soundNamed:@"Blow"];
    for (int i = 0; i < 3; i++) {
        [beep play];
        sleep(2);
    }
}


-(NSString *)lpad:(NSString *)input {
    if (input.length == 1)
        return [NSString stringWithFormat:@"0%@",input ];
    else
        return input;
}

@end
