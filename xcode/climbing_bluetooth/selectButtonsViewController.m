//
//  selectButtonsViewController.m
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 26/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "selectButtonsViewController.h"
#import "button.h"

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

-(void)viewDidAppear:(BOOL)animated{
    
    
}
@synthesize buttons;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _localGameController = [gameController getInstance];
    
    [_localGameController setDelegate:self];
    for (int i = 9; i < 15; i++) {
        [_localGameController buttonPressed:i];
    }


    [_localGameController pingButtons];
    
    _buttonCollection.backgroundColor = [UIColor colorWithWhite:0.25f alpha:0.0f];
    _buttonCollection.delegate = self;

}

- (NSDictionary*)buttons {
    buttons = [_localGameController getAvalibleButtons];
    return buttons;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSLog(@"%i items in section %i",[_localGameController getButtonsWithGroup:section].count,section);
    return [_localGameController getButtonsWithGroup:section].count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* buttonArray = [_localGameController getButtonsWithGroup:indexPath.section].allValues;

    ButtonCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"group1" forIndexPath:indexPath];
    button *button = [buttonArray objectAtIndex:indexPath.row];

    [cell setIndex:button.buttonID];
    
    cell.idLabel.text = [NSString stringWithFormat:@"%i", [button buttonID]];


//        [UIView transitionWithView:collectionView duration:.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            cell.idLabel.text = [NSString stringWithFormat:@"%i%@", [button buttonID],@"✔"];
//            //cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 40, 40);
//        } completion:^(BOOL finished) { }];
    
    cell.backgroundColor = [button identificationColor];
    [_buttonCollection invalidateIntrinsicContentSize];

    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ButtonCell *cell = (ButtonCell*) [collectionView cellForItemAtIndexPath:indexPath];
    button *button = [_localGameController getButtonWith:cell.index];

    
    if (button.groupIndex == 0) {
        [button setGroupIndex:1];

    }else{
        [button setGroupIndex:0];
    }
    
    
        [collectionView reloadData];
    
    
    //[self.buttonCollection reloadItemsAtIndexPaths:@[indexPath]];
    //NSIndexPath *n = [NSIndexPath indexPathForItem:indexPath.item inSection:[button groupIndex]];
    //[self.buttonCollection moveItemAtIndexPath:indexPath toIndexPath:n];

    //[button setGroupIndex:3];
    //[collectionView deleteItemsAtIndexPaths:@[indexPath]];
    return NO;
    
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void) buttonPressed:(button *)button{
    
}

- (IBAction)cameraButton:(id)sender {
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	[picker setDelegate: self];
	picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	[self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissViewControllerAnimated:YES completion:nil];
	[_localGameController setBackgroundImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
}

- (IBAction)AddNewButton:(id)sender {
//    ButtonCell* cell = (ButtonCell*)[self.buttonCollection cellForItemAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0]];
//    [[_localGameController getButtonWith:cell.index] setGroupIndex:1];
//    NSIndexPath *n = [NSIndexPath indexPathForItem:0 inSection:1];
//    
//    [self.buttonCollection moveItemAtIndexPath:[self.buttonCollection indexPathForCell:cell] toIndexPath:n];

}

- (void) newButtonAttatched:(button *)button buttons:(NSDictionary *)avalibleButtons{
    [_buttonCollection reloadData];
}

- (void) connectionStatusChanged:(BOOL)isConnected {
    
}

@end
