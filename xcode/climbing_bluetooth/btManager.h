//
//  btManager.h
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 18/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "button.h"

@protocol btManagerDelegate;

@interface btManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>{
    
}

@property (nonatomic, strong) CBCentralManager *manager;
@property (nonatomic, strong) CBCharacteristic *txCharacterestic;
@property (nonatomic, strong) CBCharacteristic *rxCharacterestic;

@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) CBPeripheral *peripheral;

@property (nonatomic, strong) NSString *kServiceUUID;
@property (nonatomic, strong) NSString *rsUUID;
@property (nonatomic, strong) NSString *txUUID;

@property (nonatomic, assign) id <btManagerDelegate>delegate;


- (void)send:(NSString *)Message;

@end

@protocol btManagerDelegate

-(void)buttonPressed:(int)buttonID;
-(void)connectionChanged:(BOOL)isConnected;

@end