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
    NSMutableDictionary *gameIds;
}
@property (weak, nonatomic) IBOutlet UILabel *buttonTwo;
@property (weak, nonatomic) IBOutlet UILabel *ButtonOne;
- (IBAction)startTime:(id)sender;

@end
