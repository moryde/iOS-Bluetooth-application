//
//  domination.m
//  climbing_bluetooth
//
//  Created by Morten Ydefeldt on 08/12/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "trainerModeViewController.h"

@interface trainerModeViewController ()

@end

@implementation trainerModeViewController
@synthesize labels, startPoint;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    gameController* localGameController = [gameController getInstance];
    [localGameController setDelegate:self];
	buttons = [localGameController getPlayableButtons];
    labels = [[NSMutableDictionary alloc]init];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTime:(id)sender {
    
    NSLog(@"LOL");
    
}

-(void)buttonPressed:(button *)button {
    
    
}

-(void)newButtonAttatched:(button *)button buttons:(NSDictionary *)avalibleButtons{
    
}

-(void)connectionStatusChanged:(BOOL)isConnected{
}

@end