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

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _localGameController = [gameController getInstance];
    [_localGameController setDelegate:self];
    [_localGameController pingButtons];
    NSDictionary* d = [_localGameController getAvalibleButtons];
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
    
    if (button.groupIndex == 2) {
        [sender setTitle:[NSString stringWithFormat:@"%i",button.buttonID] forState:UIControlStateNormal];
        [sender setHighlighted:YES];
        [button fadebuttonFromCurrentColorTo:[UIColor colorWithRed:0 green:0 blue:0 alpha:0] duration:1];
        [button setGroupIndex:1];
    } else {
        [sender setTitle:[NSString stringWithFormat:@"%i%@",button.buttonID, @"✓"] forState:UIControlStateNormal];
        [sender setHighlighted:NO];
        [button setGroupIndex:2];
        [button fadebuttonFrom:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] duration:1 endColor:button.identificationColor];
    }
    
    [_buttonGroup setAllButtonsWithIdentificationColor];
   //[b fadebuttonFromCurrentColorTo:[UIColor redColor] duration:2];
}

- (IBAction)cameraButton:(id)sender {
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	[self presentModalViewController:picker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
	[_localGameController setBackgroundImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
}

- (void)drawButtons:(NSDictionary*)buttons {
    
    UIScrollView *s = [[UIScrollView alloc] initWithFrame: CGRectMake(20, 100, self.view.frame.size.width-40, 200)];
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
        UIButton *uiButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        uiButton.layer.cornerRadius = (buttonsize-10)/2;
        uiButton.backgroundColor = button.identificationColor;
        [uiButton addTarget:self action:@selector(uiButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [uiButton setTag:button.buttonID];
        if (button.groupIndex == 2) {
            [uiButton setTitle:[NSString stringWithFormat:@"%i%@",button.buttonID, @"✓"] forState:UIControlStateNormal];
        } else {
            [uiButton setTitle:[NSString stringWithFormat:@"%i",button.buttonID] forState:UIControlStateNormal];
        }
        uiButton.titleLabel.font = [UIFont boldSystemFontOfSize:35];
        [uiButton setTitleColor:[UIColor colorWithWhite:1 alpha:1] forState:UIControlStateNormal];
        uiButton.frame = CGRectMake(c*buttonsize, r*buttonsize, buttonsize-10, buttonsize-10);
        
        [s addSubview:uiButton];
        [button displayIdentificationColor];
    }
    [self.view addSubview:s];
    

}

- (void) newButtonAttatched:(button *)button buttons:(NSDictionary *)avalibleButtons{
    [self drawButtons:avalibleButtons];
}

- (void) connectionStatusChanged:(BOOL)isConnected {
    
}

@end
