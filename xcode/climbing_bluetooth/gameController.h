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
#import "buttonGroup.h"

@protocol gameControllerDelegate;

@interface gameController : NSObject <btManagerDelegate, buttonDelegate> {
    btManager *btConnection;
    NSMutableDictionary *buttons;
}

- (void) connectToBase;
- (void) disconnectToBase;

- (NSMutableDictionary*) getAvalibleButtons;
- (NSMutableDictionary*) getPlayableButtons;
- (button*)getButtonWith:(long)ID;
- (void)pingButtons;

+ (gameController*) getInstance;
+ (NSString *)getHexStringForColor:(UIColor *)color;

@property (strong, nonatomic) IBOutlet UIImage *backgroundImage;
@property (nonatomic) buttonGroup *group;
@property (nonatomic, readonly) btManager *btConnection;
@property (nonatomic, assign) id <gameControllerDelegate>delegate;
@property (nonatomic) int index;


@end

@protocol gameControllerDelegate
- (void) connectionStatusChanged:(BOOL)isConnected;
- (void) buttonPressed:(button*)button;
- (void) newButtonAttatched:(button*)button buttons:(NSDictionary*)avalibleButtons;
@end