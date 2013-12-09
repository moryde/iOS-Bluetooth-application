//
//  domination.h
//  climbing_bluetooth
//
//  Created by Morten Ydefeldt on 08/12/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "gameController.h"
@interface trainerModeViewController : UIViewController <gameControllerDelegate> {
    
    NSDate *startTime;
    NSMutableDictionary *buttons;
    NSMutableDictionary *labels;
    NSTimer *uiTimer;
    CGPoint startPoint;
    
}
@property (nonatomic) NSMutableDictionary *labels;
@property (nonatomic) CGPoint startPoint;

- (IBAction)startTime:(id)sender;

@end
