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

    if ([button getId] == 11) {
       self.ButtonOne.text = [NSString stringWithFormat:@"%f",[[NSDate date]timeIntervalSinceDate:startTime]];
        [button setColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0] fadeOption:YES];

    }
    
    if ([button getId] == 10) {
        self.buttonTwo.text = [NSString stringWithFormat:@"%f",[[NSDate date]timeIntervalSinceDate:startTime]];
        [button setColor:[UIColor colorWithRed:1 green:0.5 blue:1 alpha:0]fadeOption:NO];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTime:(id)sender {
    
    startTime = [NSDate date];
}
@end
