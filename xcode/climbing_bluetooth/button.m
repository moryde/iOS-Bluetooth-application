//
//  button.m
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 18/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "button.h"


@implementation button
@synthesize buttonID,ledColor;

- (id)initWith:(int)Id
{
    self = [super init];
    if(self) {
        buttonID = Id;

        _groupIndex = 1;

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
                _identificationColor = [UIColor yellowColor];
                break;
            default:
                _identificationColor = [UIColor blueColor];
                break;
        }
    }
    return(self);
}

- (void)displayColor:(UIColor *)color fade:(BOOL)fade{
    ledColor = color;
    [self.delegate colorUpdated:self];
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
    
    _startTime = [NSDate date];
}

- (NSString *)getTime {
    
    NSTimeInterval interval = [_startTime timeIntervalSinceNow];
    NSString *s = [NSString stringWithFormat:@"%.2f",interval];
    return s;
}



@end