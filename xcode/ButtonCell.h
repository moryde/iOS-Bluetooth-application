//
//  ButtonCell.h
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 03/01/14.
//  Copyright (c) 2014 Morten Ydefeldt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "button.h"

@interface ButtonCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) button *button;
@property (nonatomic) int index;


@end

