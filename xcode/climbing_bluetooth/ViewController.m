//
//  ViewController.m
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 15/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "ViewController.h"
#import "selectButtonsViewController.h"
#import "gameController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize debugView ,connecToBase;

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

- (IBAction)connecToBase:(id)sender {
    
    gameController* localGameController = [gameController getInstance];
    [localGameController connectToBase];
    
    [sender setImage:[UIImage imageNamed:@"connectToBase_Connected.png"] forState:UIControlStateNormal];
    [sender setTitle:@"Disconnect" forState:UIControlStateNormal];

}

- (IBAction)newGame:(id)sender {
    
}


@end