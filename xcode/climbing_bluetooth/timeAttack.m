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
@synthesize labels,startPoint,buttonCount;

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
    
    _localGameController = [gameController getInstance];
    [_localGameController setDelegate:self];
	buttons = [_localGameController getPlayableButtons];
    labels = [[NSMutableDictionary alloc]init];
    [self drawUI];

}

- (void)viewDidDisappear:(BOOL)animated {
    
    labels = nil;

}

- (void)buttonPressed:(button *)button{
    buttonCount++;
    [button displayIdentificationColor];
    id key = [buttons allKeysForObject:button];
    [button stopTime];
        UILabel *l = [labels objectForKey:key[0]];
        l.text = [NSString stringWithFormat:@"%f",[[NSDate date]timeIntervalSinceDate:startTime]];
        l.backgroundColor = [button identificationColor];
    
    if (buttonCount == [buttons count]) {
        buttonCount = 0;
        [self.gameControlButton setTitle:@"Start Game" forState:UIControlStateNormal];
        [uiTimer invalidate];
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTime:(id)sender {
    [self.gameControlButton setTitle:@"End Game" forState:UIControlStateNormal];
    uiTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
    startTime = [NSDate date];
    
    
    for (id key in labels) {
        UILabel *label = labels[key];
        label.backgroundColor = [UIColor redColor];
        button* b = buttons[key];
        [b displayColor:[UIColor redColor] fade:NO];
        [b startTimerFromNow];
    }
}

- (void)updateUI{
        for (id key in buttons) {
            UILabel *l =[labels objectForKey:key];
            l.text = [buttons[key] getTime];
            [self.view addSubview:l];
        }
}

- (void)drawUI{
    int i = 0;
    if ([_localGameController backgroundImage]) {
        self.backgroundView.image = [_localGameController backgroundImage];
    }
    for (id key in buttons) {
        button *button = [buttons objectForKey:key];
        CGPoint p = [button uiPosition];
        
        
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(p.x, p.y, 100, 30)];
        l.layer.cornerRadius = 10;
        l.layer.borderColor = [UIColor whiteColor].CGColor;
        l.layer.borderWidth = 2;
        l.backgroundColor = button.identificationColor;
        l.font = [UIFont boldSystemFontOfSize:20];
        l.textColor = [UIColor whiteColor];
        l.text = [NSString stringWithFormat:@"%@%i",@"  ", button.buttonID];
        l.tag = button.buttonID;
        l.layer.shadowColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5].CGColor;
        l.layer.shadowOffset = CGSizeMake(0.0, -1.0);
        l.layer.shadowRadius = 3.0;
        l.layer.shadowOpacity = 0.5;
        [l setUserInteractionEnabled:YES];
        UIPanGestureRecognizer *touchReconizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(labelTouched:)];

        [l addGestureRecognizer:touchReconizer];
        
        [self.labels setObject:l forKey:key];
        [self.view addSubview:l];
        
        i++;

    }
}

-(void)labelTouched:(UIPanGestureRecognizer *)gesture
{
    // Check if this is the first touch
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        // Store the initial touch so when we change positions we do not snap
        self.startPoint = [gesture locationInView:gesture.view];
        [self.view bringSubviewToFront:gesture.view];
    }
    
    CGPoint newCoord = [gesture locationInView:gesture.view];
    
    // Create the frame offsets to use our finger position in the view.
    float dX = newCoord.x-self.startPoint.x;
    float dY = newCoord.y-self.startPoint.y;
    
    gesture.view.frame = CGRectMake(gesture.view.frame.origin.x+dX,
                                    gesture.view.frame.origin.y+dY,
                                    gesture.view.frame.size.width,
                                    gesture.view.frame.size.height);
    
    button *b = [buttons objectForKey:[NSString stringWithFormat:@"%li", (long)gesture.view.tag]];
    [b setUiPosition:gesture.view.frame.origin];
    NSLog(@"%@", NSStringFromCGPoint([b uiPosition]));
}

-(void)connectionStatusChanged:(BOOL)isConnected{
    
}

-(void)newButtonAttatched:(button *)button buttons:(NSDictionary *)avalibleButtons {
    
}

@end
