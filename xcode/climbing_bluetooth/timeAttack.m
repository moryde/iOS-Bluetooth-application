//
//  timeAttack.m
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 27/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "timeAttack.h"

@interface timeAttack ()

@end

@implementation timeAttack
@synthesize ButtonOne,buttonTwo;

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
	gameIds = [localGameController getAvalibleButtons];
    
}

- (void)buttonPressed:(button *)button{
    if (button.buttonID == 11) {
       self.ButtonOne.text = [NSString stringWithFormat:@"%f",[[NSDate date]timeIntervalSinceDate:startTime]];
        [button fadebuttonFrom:[UIColor colorWithRed:0 green:0 blue:1 alpha:1] duration:2 endColor:[UIColor colorWithRed:0 green:1 blue:0 alpha:1]];

    }
    
    if (button.buttonID == 10) {
        self.buttonTwo.text = [NSString stringWithFormat:@"%f",[[NSDate date]timeIntervalSinceDate:startTime]];
        [button fadebuttonFrom:[UIColor colorWithRed:0 green:0 blue:1 alpha:1] duration:2 endColor:[UIColor colorWithRed:0 green:1 blue:0 alpha:1]];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTime:(id)sender {
    NSTimer* uiTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];

    startTime = [NSDate date];
}

- (void)updateUI{
    self.ButtonOne.text = [NSString stringWithFormat:@"%f",[[NSDate date]timeIntervalSinceDate:startTime]];
}
@end
