//
//  timeAttack.h
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 27/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gameController.h"
@interface timeAttack : UIViewController <gameControllerDelegate> {
    
    NSDate *startTime;
    NSMutableDictionary *buttons;
    NSMutableDictionary *labels;
    NSMutableDictionary *inGameButtons;
    NSTimer *uiTimer;
    CGPoint startPoint;
    int buttonCount;

}
@property (nonatomic) int buttonCount;
@property (nonatomic) NSMutableDictionary *labels;
@property (nonatomic) CGPoint startPoint;
@property (weak, nonatomic) IBOutlet UIButton *gameControlButton;


- (IBAction)startTime:(id)sender;

@end
