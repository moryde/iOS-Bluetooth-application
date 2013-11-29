//
//  button.m
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 18/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "button.h"

@implementation button
@synthesize buttonID,ledColor,currentlyInGame,identificationColor;

- (id)initWith:(int)Id
{
    self = [super init];
    if(self) {
        buttonID = Id;
        currentlyInGame = NO;
        switch (Id) {
            case 10:
                identificationColor = [UIColor blueColor];
                break;
            case 11:
                identificationColor = [UIColor redColor];
                break;
            default:
                identificationColor = [UIColor yellowColor];
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
    
    [self displayColor:self.identificationColor fade:YES];
}

@end