//
//  buttonGroup.h
//  climbing_bluetooth
//
//  Created by Morten Ydefeldt on 15/12/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface buttonGroup : NSObject {
    
    
}

@property (nonatomic) NSMutableArray *buttons;
@property (nonatomic) int groupIndex;

- (id) initWithGroupIndex:(int) groupIndex;
- (void) turnAllButtonsOff;
- (void) setAllButtonsWithIdentificationColor;



@end

