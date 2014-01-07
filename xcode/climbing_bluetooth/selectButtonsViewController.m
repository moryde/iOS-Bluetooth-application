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
    [_localGameController pingButtons];
    
    [_localGameController buttonPressed:10];
    [_localGameController buttonPressed:11];
    [_localGameController buttonPressed:12];
    [_localGameController buttonPressed:24];
    [_localGameController buttonPressed:25];
    [_localGameController buttonPressed:30];
    [_localGameController buttonPressed:19];
    [_localGameController buttonPressed:16];

    _buttonCollection.backgroundColor = [UIColor colorWithWhite:0.25f alpha:0.0f];
    _buttonCollection.delegate = self;

}

- (NSArray*)buttons {
    buttons = [[_localGameController getAvalibleButtons] allValues];
    return buttons;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.buttons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    int i = (int)indexPath.row;
    button *button = self.buttons[i];
    ButtonCell *cell = [[ButtonCell alloc] init];
    NSIndexPath *p = button.indexPath;
    if (button.groupIndex == 1) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"group1" forIndexPath:indexPath];
        
        [UIView transitionWithView:collectionView duration:.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            cell.idLabel.text = [NSString stringWithFormat:@"%i", [button buttonID]];
            cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 30, 30);
        } completion:^(BOOL finished) { }];

    }else
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"group2" forIndexPath:indexPath];
        
        [UIView transitionWithView:collectionView duration:.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            cell.idLabel.text = [NSString stringWithFormat:@"%i%@", [button buttonID],@"SELECTED"];
            cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 40, 40);
        } completion:^(BOOL finished) { }];
        
        
        

    }
    cell.backgroundColor = [button identificationColor];
    [_buttonCollection invalidateIntrinsicContentSize];
    NSLog(@"LOOO");
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    int i = (int)indexPath.row;
    button *button = self.buttons[i];
    
    if (button.groupIndex == 1) {
        [button setGroupIndex:2];
        
    }else{
        [button setGroupIndex:1];
    }
    
    [self.buttonCollection reloadItemsAtIndexPaths:@[indexPath]];
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
    [_localGameController buttonPressed:99];
}

- (void) newButtonAttatched:(button *)button buttons:(NSDictionary *)avalibleButtons{
    [_buttonCollection reloadData];
}

- (void) connectionStatusChanged:(BOOL)isConnected {
    
}

@end
