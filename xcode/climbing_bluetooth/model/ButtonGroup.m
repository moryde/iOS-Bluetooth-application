//
//  ButtonGroup.m
//  climbing_bluetooth
//
//  Created by Morten Ydefeldt on 15/12/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "ButtonGroup.h"
#import "button.h"

@interface ButtonGroup()

@end


@implementation ButtonGroup {
    
}

- (ButtonGroup*) initWithGroupIndex:(int)groupID {
    NSLog(@"initWithIndex");
    _groupIndex = groupID;
    return self;
}

- (void) setAllButtonsWithIdentificationColor{
    NSLog(@"setAllButtonsWithIdentificationColor");
    for (button *b in _buttons) {
        if ([b groupIndex] == _groupIndex) {
            [self updateAllButtons];
        }
    }
}

- (void) turnAllButtonsOff {
        NSLog(@"turnAllButtonsOff");
    
}

- (void)updateAllButtons {
        NSLog(@"updateAllButtons");
    
    for (button *b in _buttons) {
        [b setGroupIndex:_groupIndex];
        [b displayIdentificationColor];
    }
}



@end
