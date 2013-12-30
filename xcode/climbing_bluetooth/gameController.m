//
//  gameController.m
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 26/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "gameController.h"

@implementation gameController
@synthesize delegate, btConnection;


static gameController *singletonInstance;

-(int)index{
    return 2;
}

- (buttonGroup*) group {
    NSLog(@"group");
    if (!_group) {
        _group = [_group initWithGroupIndex:self.index];
    }
    return _group;
}

-(id)init
{
    if (self = [super init])
    {
        buttons = [[NSMutableDictionary alloc] init];
        NSLog(@"buttons created");
    }
    return self;
}

- (void)connectionChanged:(BOOL)isConnected{
 
    [delegate connectionStatusChanged:isConnected];
}

+ (gameController*)getInstance{
    if (singletonInstance == nil) {
        singletonInstance = [[super alloc] init];
    }
    return singletonInstance;
}

- (NSMutableDictionary*) getAvalibleButtons{

    return buttons;
}

- (button*)getButtonWith:(long)ID {
    
    button* button = [buttons valueForKey:[NSString stringWithFormat:@"%li",ID]];
    return button;

}

-(void)pingButtons{
    
    for (int i = 2; i <= 30; i++) {
        NSString *j = [NSString stringWithFormat:@"%i",i];
        NSMutableString *ss = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%02lX", (long)[j integerValue]]];
        [btConnection send:ss];
    }
    
}


- (void) connectToBase {
    
    btConnection = [[btManager alloc]init];
    [btConnection setDelegate:self];
}

- (void) disconnectToBase {
    //To do!
    [btConnection.manager cancelPeripheralConnection:btConnection.peripheral];
}

- (void) colorUpdated:(button*)button {
    NSString *dec = [NSString stringWithFormat:@"%i",button.buttonID];
    NSMutableString *ss = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%02lX", (long)[dec integerValue]]];
    [ss appendString:[gameController getHexStringForColor:button.ledColor]];
    [btConnection send:ss];
}

- (void) fadebuttonFrom:(UIColor *)startColor duration:(int)Seconds endColor:(UIColor *)endColor button:(button *)button{

    NSString *i = [NSString stringWithFormat:@"%i",button.buttonID];
    NSString *sec = [NSString stringWithFormat:@"%i",Seconds];

    NSMutableString *ss = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%02lX", (long)[i integerValue]]];
    [ss appendString:[gameController getHexStringForColor:startColor]];
    [ss appendString:[NSString stringWithFormat:@"%02lX", [sec integerValue]]];
    [ss appendString:[gameController getHexStringForColor:endColor]];
    [btConnection send:ss];

}

- (void)fadeButtonFromCurrentColorTo:(UIColor *)endColor duration:(int)seconds button:(button *)button {
    NSString *i = [NSString stringWithFormat:@"%i",button.buttonID];
    NSString *sec = [NSString stringWithFormat:@"%i",seconds];
    
    NSMutableString *ss = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%02lX", (long)[i integerValue]]];
    [ss appendString:[NSString stringWithFormat:@"%02lX", [sec integerValue]]];

    [ss appendString:[gameController getHexStringForColor:endColor]];
    
    [btConnection send:ss];
}

+ (NSString *)getHexStringForColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString=[NSString stringWithFormat:@"%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
    return hexString;
}

- (NSMutableDictionary *) getPlayableButtons {
    NSMutableDictionary* a = [[NSMutableDictionary alloc] init];
    for (id key in buttons) {
        button *b = [buttons objectForKey:key];        
        if (b.groupIndex == self.index) {
            [a setObject:b forKey:key];
            NSLog(@"Matching button");

        }else{
            NSLog(@"NOGET ANDET");
        }
    }
    return a;
}

-(void)buttonPressed:(int)buttonID{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    button* b = [buttons valueForKey:[NSString stringWithFormat:@"%i",buttonID]];
    //Check if button exsists
    
    if(!b){
        b = [[button alloc] initWith:buttonID];
        [b setDelegate:self];
        [buttons setObject:b forKey:[NSString stringWithFormat:@"%i", buttonID]];
        [delegate newButtonAttatched:b buttons:buttons];
    }
    
    [delegate buttonPressed:b];
}

@end

