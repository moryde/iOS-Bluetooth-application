//
//  gameController.h
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 26/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "btManager.h"
#import "button.h"

@protocol gameControllerDelegate,gameDelegate;

@interface gameController : NSObject <btManagerDelegate, buttonDelegate> {
    btManager *btConnection;
    NSMutableDictionary *buttons;
}

- (void) connectToBase;
- (NSMutableDictionary*) getAvalibleButtons;
- (NSMutableDictionary*) getPlayableButtons;
- (button*)getButtonWith:(long)ID;

+ (gameController*) getInstance;
+ (NSString *)getHexStringForColor:(UIColor *)color;


@property (nonatomic, assign) id <gameControllerDelegate>delegate;

@end

@protocol gameControllerDelegate
- (void) buttonPressed:(button*)button;
- (void) newButtonAttatched:(button*)button buttons:(NSDictionary*)avalibleButtons;
@end