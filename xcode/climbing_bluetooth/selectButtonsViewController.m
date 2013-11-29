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
        baseColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
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
    button* button = [localGameController getButtonWith:[sender tag]];
    
    if (button.currentlyInGame) {
        [sender setTitle:[NSString stringWithFormat:@"%i",button.buttonID] forState:UIControlStateNormal];
        [button fadebuttonFromCurrentColorTo:[UIColor colorWithRed:0 green:0 blue:0 alpha:0] duration:1];
        
    } else {
        [sender setTitle:[NSString stringWithFormat:@"%i%@",button.buttonID, @"✓"] forState:UIControlStateNormal];
        [button fadebuttonFrom:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] duration:1 endColor:button.physicalColor];
    }
    button.currentlyInGame = !button.currentlyInGame;
    
    
   //[b fadebuttonFromCurrentColorTo:[UIColor redColor] duration:2];
}

- (void)drawButtons:(NSDictionary*)buttons {
    UIScrollView *s = [[UIScrollView alloc] initWithFrame: CGRectMake(20, 100, self.view.frame.size.width-40, 500)];
    s.contentSize = CGSizeMake(s.frame.size.width,500);
    s.scrollEnabled = YES;
    
    int i = 0;
    int r = 0;
    int c = 0;
    
    for (id key in buttons){
        button *button = [buttons objectForKey:key];
        c = i%coloumCount;
        r = i/coloumCount;
        i++;
        NSLog(@"test");
        UIButton *uiButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        uiButton.layer.cornerRadius = (buttonsize-10)/2;
        uiButton.backgroundColor = button.physicalColor;
        [uiButton addTarget:self action:@selector(uiButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [uiButton setTag:button.buttonID];
        if (button.currentlyInGame) {
            NSLog(@"omg lol");
            [uiButton setTitle:[NSString stringWithFormat:@"%i%@",button.buttonID, @"✓"] forState:UIControlStateNormal];
        } else {
            [uiButton setTitle:[NSString stringWithFormat:@"%i",button.buttonID] forState:UIControlStateNormal];
        }
        uiButton.titleLabel.font = [UIFont boldSystemFontOfSize:35];
        [uiButton setTitleColor:[UIColor colorWithWhite:1 alpha:1] forState:UIControlStateNormal];
        uiButton.frame = CGRectMake(c*buttonsize, r*buttonsize, buttonsize-10, buttonsize-10);
        
        [s addSubview:uiButton];
        [button displayPhysicalColor];
    }
    [self.view addSubview:s];
    

}

- (void) newButtonAttatched:(button *)button buttons:(NSDictionary *)avalibleButtons{
    [self drawButtons:avalibleButtons];
}

@end
