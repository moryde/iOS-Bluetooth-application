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
    }
    return(self);
}

- (int) getId{
    return buttonID;
}

- (void)setColor:(UIColor*)color fadeOption:(BOOL)fade{
    
    ledColor = color;
    if (fade) NSLog(@"LOL");
    [self.delegate colorUpdated:self];

}

- (UIColor*)getColor {
    
    return ledColor;
}


- (void)fadebuttonFrom:(UIColor *)startColor duration: (int)seconds endColor:(UIColor*)endColor {
    
    [self.delegate fadebuttonFrom:startColor duration:seconds endColor:endColor button:self];
}

- (void)fadebuttonFromCurrentColorTo:(UIColor *)endColor duration:(int)seconds {
    [self.delegate fadeButtonFromCurrentColorTo:endColor duration:seconds button:self];
}

@end