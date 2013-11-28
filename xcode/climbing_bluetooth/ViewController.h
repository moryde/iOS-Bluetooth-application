//
//  ViewController.h
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 15/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {

}

@property (weak, nonatomic) IBOutlet UITextView *debugView;


- (IBAction)refreshPeripheral:(id)sender;
- (IBAction)connecToBase:(id)sender;
- (IBAction)newGame:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *connecToBase;

@end


