//
//  selectButtonsViewController.m
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 26/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "selectButtonsViewController.h"
#define buttonsize 120
#define coloumCount 2

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
    
    UIScrollView *s = [[UIScrollView alloc] initWithFrame: CGRectMake(20, 100, self.view.frame.size.width-40, 300)];
    s.contentSize = CGSizeMake(s.frame.size.width,500);
    s.scrollEnabled = YES;
    s.scroll
    [s setBackgroundColor:[UIColor colorWithRed:0.1 green:1 blue:0.3 alpha:1]];
    int i = 0;
    int r = 0;
    int c = 0;
    
    for (id key in d){
        
        c = i%coloumCount;
        r = i/coloumCount;
        i++;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.layer.cornerRadius = (buttonsize-10)/2;
        button.backgroundColor = [UIColor colorWithRed:0.1 green:0.3 blue:0.3 alpha:1];
        [button addTarget:self action:@selector(uiButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [button setTag:[d[key]getId]];
        [button setTitle:[NSString stringWithFormat:@"%i",[d[key] getId]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        button.frame = CGRectMake(c*buttonsize, r*buttonsize, buttonsize-10, buttonsize-10);
        
        [s addSubview:button];
    }
    [self.view addSubview:s];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) buttonPressed:(button *)button{
    
    
}

- (void)uiButtonPressed:(id)sender{
    
    NSLog(@"%i",[sender tag]);
    
}

@end
