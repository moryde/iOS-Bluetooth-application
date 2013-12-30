//
//  domination.m
//  climbing_bluetooth
//
//  Created by Morten Ydefeldt on 08/12/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "domination.h"
#import "button.h"

@interface domination ()

@end

@implementation domination
@synthesize labels,gameTimeSlider, startPoint,score,timeLabel,scoreLabel,gameTime,startButton,uiTimer,lastButtonPressed;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startGame:(id)sender {
    
    for (id key in buttons) {
        button *button = [buttons objectForKey:key];
        [button displayColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0] fade:YES];
    }
    
    scoreLabel.text = @"0";
    timeLabel.text = [NSString stringWithFormat:@"%i",gameTime];
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:gameTime-1 target:self selector:@selector(gameEnded) userInfo:nil repeats:NO];
    uiTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
    startTime = [NSDate date];
    [startButton setTitle:@"End Game" forState:UIControlStateNormal];
    gameTimeSlider.enabled = NO;
    [self turnOnRandomButton];
}

- (IBAction)gameTimeSlider:(UISlider*)sender {
    
        gameTime = sender.value;
        timeLabel.text = [NSString stringWithFormat:@"%i", gameTime];

}

-(void)buttonPressed:(button *)button {
    
    if (button.buttonID == lastButtonPressed) {
        if (gameTimer) {
            score++;
            scoreLabel.text = [NSString stringWithFormat:@"%i",score];
            [button displayColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0] fade:NO];
            [self turnOnRandomButton];
        }
    }

}

-(void) gameEnded {
    
    [startButton setTitle:@"Start game" forState:UIControlStateNormal];
    gameTimer = nil;
    [uiTimer invalidate];
    uiTimer = nil;
    timeLabel.text = [NSString stringWithFormat:@"%i",gameTime];
    gameTimeSlider.enabled = YES;
}

-(void)updateUI{

int i = gameTime-[[NSDate date]timeIntervalSinceDate:startTime];
    timeLabel.text = [NSString stringWithFormat:@"%i",i];
    
}

-(void)newButtonAttatched:(button *)button buttons:(NSDictionary *)avalibleButtons{
    
}

-(void)connectionStatusChanged:(BOOL)isConnected{
}


- (void)turnOnRandomButton{

    NSArray *array = [buttons allKeys];
    int random = arc4random()%[array count];
    
    while ([[array objectAtIndex:random] isEqualToString: [NSString stringWithFormat:@"%i", lastButtonPressed]]) {
        random = arc4random()%[array count];
        NSLog(@"4");

    }
    NSLog(@"5");
    NSString *key = [array objectAtIndex:random];
    lastButtonPressed = key.intValue;
    button* button = [buttons objectForKey:key];
    [button displayColor:button.identificationColor fade:NO];
}



@end
