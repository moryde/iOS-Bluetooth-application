//
//  button.m
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 18/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "button.h"


@implementation button {
    
}



@synthesize buttonID,ledColor;


- (button*)initWith:(int)Id
{
    self = [super init];
    if(self) {
        _shouldVibrate = NO;
        buttonID = Id;
        _groupIndex = 0;
        _uiPosition = CGPointMake(100,100);
        switch (buttonID) {
            case 10:
                _identificationColor = [UIColor orangeColor];
                break;
            case 11:
                _identificationColor = [UIColor magentaColor];
                break;
            case 16:
                _identificationColor = [UIColor purpleColor];
                break;
            case 13:
                _identificationColor = [UIColor blueColor];
                break;
            case 20:
                _identificationColor = [UIColor brownColor];
                break;
            default:
                _identificationColor = [UIColor blueColor];
                break;
        }
    }
    return(self);
}



- (void)setGroupIndex:(int)groupIndex {
    _groupIndex = groupIndex;
    if (groupIndex == 2) {
        [self fadebuttonFrom:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] duration:1 endColor:self.identificationColor];
    }
    else if (groupIndex == 1) {
        [self fadebuttonFrom:self.identificationColor duration:2 endColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    }

}
- (void)displayColor:(UIColor *)color fade:(BOOL)fade{
    ledColor = color;
    [self.delegate colorUpdated:self];
    NSLog(@"DisplayColor");
}
- (void)fadebuttonFrom:(UIColor *)startColor duration: (int)seconds endColor:(UIColor*)endColor {
    
    [self.delegate fadebuttonFrom:startColor duration:seconds endColor:endColor button:self];
}

- (void)fadebuttonFromCurrentColorTo:(UIColor *)endColor duration:(int)seconds {
    [self.delegate fadeButtonFromCurrentColorTo:endColor duration:seconds button:self];
}

- (void)displayIdentificationColor{
    
    [self displayColor:_identificationColor fade:NO];
}

- (void)startTimerFromNow {
    self.startTime = [NSDate date];
    _shouldVibrate = YES;
}

- (NSString *)getTime {
    NSLog(@"GET TIME");
    [self updateTime];
    NSString *s = [NSString stringWithFormat:@"%.2f",fabs(self.time)];
    return s;
}

- (void)stopTime {
    [self updateTime];
    self.startTime = nil;
    _shouldVibrate = NO;
}

- (void)updateTime{
    if (self.startTime) {
        self.time = [self.startTime timeIntervalSinceNow];
    }
    
}


@end