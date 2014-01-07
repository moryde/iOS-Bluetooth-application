//
//  gameController.h
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 26/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "btManager.h"
#import "button.h"
#import "ButtonGroup.h"

@protocol gameControllerDelegate;

@interface gameController : NSObject <btManagerDelegate, buttonDelegate> {

}
@property (nonatomic) NSMutableDictionary* buttons;
@property (nonatomic,strong) IBOutlet UIImage *backgroundImage;
@property (nonatomic) ButtonGroup* group;
@property (nonatomic, readonly) btManager *btConnection;
@property (nonatomic, assign) id <gameControllerDelegate>delegate;
@property (nonatomic) int index;


- (void) connectToBase;
- (void) disconnectToBase;

- (NSMutableDictionary*) getAvalibleButtons;
- (NSMutableDictionary*) getPlayableButtons;
- (button*)getButtonWith:(long)ID;

+ (gameController*) getInstance;
+ (NSString *)getHexStringForColor:(UIColor *)color;

- (void)pingButtons;

@end

@protocol gameControllerDelegate
    - (void) connectionStatusChanged:(BOOL)isConnected;
    - (void) buttonPressed:(button*)button;
    - (void) newButtonAttatched:(button*)button buttons:(NSDictionary*)avalibleButtons;
@end