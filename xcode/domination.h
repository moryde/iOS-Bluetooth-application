//
//  domination.h
//  climbing_bluetooth
//
//  Created by Morten Ydefeldt on 08/12/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "gameController.h"
@interface domination : UIViewController <gameControllerDelegate> {
    
    NSDate *startTime;
    NSMutableDictionary *buttons;
    NSMutableDictionary *labels;
    NSTimer *uiTimer;
    NSTimer *gameTimer;
    CGPoint startPoint;
    int gameTime;
    int score;
    int lastButtonPressed;
    
}
@property (nonatomic) NSMutableDictionary *labels;
@property (nonatomic) CGPoint startPoint;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic) int gameTime;
@property (nonatomic) int score;
@property (weak, nonatomic) IBOutlet UISlider *gameTimeSlider;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic) NSTimer* uiTimer;
@property (nonatomic) int lastButtonPressed;
- (IBAction)startGame:(id)sender;

- (IBAction)gameTimeSlider:(id)sender;


@end
