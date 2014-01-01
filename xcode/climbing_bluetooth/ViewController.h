//
//  ViewController.h
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 15/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gameController.h"

@interface ViewController : UIViewController <gameControllerDelegate>{

}

@property (weak, nonatomic) IBOutlet UIButton *connectToBase;

- (IBAction)connectToBase:(id)sender;
- (IBAction)newGame:(id)sender;

@end


