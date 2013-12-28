//
//  ViewController.m
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 15/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "ViewController.h"
#import "selectButtonsViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize debugView, connectToBase;

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connectToBase:(id)sender {
    gameController *localGameController = [gameController getInstance];
    [localGameController setDelegate:self];
    [connectToBase setTitle:@"Connecting..." forState:UIControlStateNormal];

    if (localGameController.btConnection) {
        [localGameController disconnectToBase];
    } else {
        [localGameController connectToBase];
    }


}

- (void)connectionStatusChanged:(BOOL)isConnected{
    if (isConnected) {
        [connectToBase setImage:[UIImage imageNamed:@"connectToBase_Connected.png"] forState:UIControlStateNormal];
        [connectToBase setTitle:@"Disconnect" forState:UIControlStateNormal];
    }else {
        [connectToBase setImage:[UIImage imageNamed:@"connectToBase.png"] forState:UIControlStateNormal];
        [connectToBase setTitle:@"Connect to base" forState:UIControlStateNormal];
    }

}

- (IBAction)newGame:(id)sender {
    
}

- (void)buttonPressed:(button *)button{
    
}

- (void)newButtonAttatched:(button *)button buttons:(NSDictionary *)avalibleButtons{
    
}

@end