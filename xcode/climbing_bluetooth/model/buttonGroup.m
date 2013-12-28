//
//  buttonGroup.m
//  climbing_bluetooth
//
//  Created by Morten Ydefeldt on 15/12/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "buttonGroup.h"
#import "button.h"

@interface buttonGroup()

@end


@implementation buttonGroup {
    
}

- (id) initWithGroupIndex:(int) groupIndex{
    return  nil;
}

- (void) setAllButtonsWithIdentificationColor{

    for (button *b in _buttons) {
        if ([b groupIndex] == _groupIndex) {
            [self updateAllButtons];
        }
    }
}

- (void) turnAllButtonsOff {
    
    
}

- (buttonGroup*) initWithIndex:(int)groupID {
    _groupIndex = groupID;
    return self;
}

- (void)updateAllButtons {
    
    for (button *b in _buttons) {
        [b setGroupIndex:_groupIndex];
        [b displayIdentificationColor];
    }
}



@end
