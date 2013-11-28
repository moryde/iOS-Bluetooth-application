//
//  selectButtonsViewController.h
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 26/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gameController.h"


@interface selectButtonsViewController : UIViewController <gameControllerDelegate>{
    NSString *myString;

}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (void)drawButtons:(NSDictionary*)buttons;

@end

