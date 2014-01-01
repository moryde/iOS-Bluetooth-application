//
//  selectButtonsViewController.h
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 26/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gameController.h"
#import "buttonGroup.h"


@interface selectButtonsViewController : UIViewController <gameControllerDelegate>{

}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet buttonGroup *buttonGroup;
@property (nonatomic) gameController *localGameController;


- (IBAction)cameraButton:(id)sender;


- (void)drawButtons:(NSDictionary*)buttons;


@end