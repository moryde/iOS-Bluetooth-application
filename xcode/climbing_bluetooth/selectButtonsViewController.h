//
//  selectButtonsViewController.h
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 26/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gameController.h"
#import "ButtonGroup.h"
#import "ButtonCell.h"

@interface selectButtonsViewController : UIViewController <gameControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{

}

@property (weak, nonatomic) IBOutlet NSDictionary *buttons;
@property (nonatomic) gameController *localGameController;

- (IBAction)cameraButton:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *buttonCollection;

- (IBAction)AddNewButton:(id)sender;


@end