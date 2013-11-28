//
//  selectButtonsViewController.m
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 26/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "selectButtonsViewController.h"
#define buttonsize 90
#define coloumCount 3

@interface selectButtonsViewController ()

@end

@implementation selectButtonsViewController

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
	// Do any additional setup after loading the view.
    gameController* localGameController = [gameController getInstance];
     [localGameController setDelegate:self];
    
    NSDictionary* d = [localGameController getAvalibleButtons];
    [self drawButtons:d];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) buttonPressed:(button *)button{
    
    
}

- (void)uiButtonPressed:(id)sender{
    
    gameController* localGameController = [gameController getInstance];

    button* b = [localGameController getButtonWith:[sender tag]];
    NSLog(@"button pressed");
   //[b fadebuttonFromCurrentColorTo:[UIColor redColor] duration:2];
    [b fadebuttonFrom:[UIColor colorWithRed:1 green:0 blue:0 alpha:1] duration:2 endColor:[UIColor colorWithRed:0 green:1 blue:0 alpha:1]];
}

- (void)drawButtons:(NSDictionary*)buttons {
    
    UIScrollView *s = [[UIScrollView alloc] initWithFrame: CGRectMake(20, 100, self.view.frame.size.width-40, 500)];
    s.contentSize = CGSizeMake(s.frame.size.width,500);
    s.scrollEnabled = YES;
    
    int i = 0;
    int r = 0;
    int c = 0;
    
    for (id key in buttons){
        
        c = i%coloumCount;
        r = i/coloumCount;
        i++;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.layer.cornerRadius = (buttonsize-10)/2;
        button.backgroundColor = [UIColor colorWithRed:0.1 green:0.3 blue:0.3 alpha:1];
        [button addTarget:self action:@selector(uiButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [button setTag:[buttons[key]getId]];
        [button setTitle:[NSString stringWithFormat:@"%i",[buttons[key] getId]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:35];
        [button setTitleColor:[UIColor colorWithWhite:1 alpha:1] forState:UIControlStateNormal];
        button.frame = CGRectMake(c*buttonsize, r*buttonsize, buttonsize-10, buttonsize-10);
        
        [s addSubview:button];
    }
    [self.view addSubview:s];
    

}

- (void)newButtonAttatched:(button *)button :(NSDictionary *)avalibleButtons {
    
    [self drawButtons:avalibleButtons];
}

@end
