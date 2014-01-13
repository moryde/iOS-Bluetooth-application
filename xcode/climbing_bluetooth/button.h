//
//  button.h
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 18/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol buttonDelegate;

@interface button : NSObject {
    
    int buttonID;
    UIColor* ledColor;
    
}
@property (nonatomic, assign) id <buttonDelegate>delegate;

@property (nonatomic) UIColor* ledColor;
@property (nonatomic) int buttonID;
@property (nonatomic) UIColor* identificationColor;
@property (nonatomic) int groupIndex;
@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSTimeInterval time;
@property (nonatomic) CGPoint uiPosition;
@property (nonatomic) BOOL shouldVibrate;

- (id)initWith:(int)Id;
- (void)displayColor:(UIColor*)color fade:(BOOL)fade;
- (void)fadebuttonFrom:(UIColor*)startColor duration:(int)seconds endColor:(UIColor*)endColor;
- (void)fadebuttonFromCurrentColorTo:(UIColor *)endColor duration:(int)seconds;
- (void)displayIdentificationColor;
- (void)startTimerFromNow;
- (void)stopTime;

- (NSString*)getTime;

@end


@protocol buttonDelegate

-(void)colorUpdated:(button*)button;
-(void)fadebuttonFrom:(UIColor *)startColor duration: (int)seconds endColor:(UIColor*)endColor button:(button*)button;
-(void)fadeButtonFromCurrentColorTo:(UIColor *)endColor duration:(int)seconds button:(button*)button;

@end