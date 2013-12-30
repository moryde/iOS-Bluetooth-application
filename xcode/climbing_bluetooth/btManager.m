//
//  btManager.m
//  Climbing_bluetooth
//
//  Created by Morten Ydefeldt on 18/11/13.
//  Copyright (c) 2013 Morten Ydefeldt. All rights reserved.
//

#import "btManager.h"

@implementation btManager
@synthesize delegate,rsUUID,txUUID,txCharacterestic,rxCharacterestic, manager;

-(id)init
{

    if (self = [super init])
    {
        self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}


-(NSDictionary*)getCharacteristics{
    return  nil;
}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central {
    self.kServiceUUID = @"B8E06067-62AD-41BA-9231-206AE80AB550";
    self.rsUUID = @"F897177B-AEE8-4767-8ECC-CC694FD5FCEE";
    self.txUUID = @"BF45E40A-DE2A-4BC8-BBA0-E5D6065F1B4B";
    
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            [self.manager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:_kServiceUUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey: @YES }];
            break;
        case CBCentralManagerStatePoweredOff:
            
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    [self.manager stopScan];
    
    if (self.peripheral != peripheral) {
        self.peripheral = peripheral;
        [self.manager connectPeripheral:peripheral options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {

    // Clears the data that we may already have
    [self.data setLength:0];
    // Sets the peripheral delegate
    [self.peripheral setDelegate:self];
    // Asks the peripheral to discover the service
    [self.peripheral discoverServices:nil];
    
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
    [delegate connectionChanged:NO];
}

- (void)peripheral:(CBPeripheral *)aPeripheral didDiscoverServices:(NSError *)error {
    if (error) {
        //NSLog(@"Error discovering service: %@", [error localizedDescription]);
        return;
    }
    for (CBService *service in aPeripheral.services) {
        // Discovers the characteristics for a given service
        if ([service.UUID isEqual:[CBUUID UUIDWithString:_kServiceUUID]]) {
            [self.peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {
        NSLog(@"Error discovering characteristic: %@", [error localizedDescription]);
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:_kServiceUUID]]) {
        for (CBCharacteristic *characteristic in service.characteristics) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:txUUID]]) {
                txCharacterestic = characteristic;

            }
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:rsUUID]]) {
                rxCharacterestic = characteristic;
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            }
        }
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    // Exits if it's not the transfer characteristic
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:rsUUID]]) {
        return;
    }
    
    // Notification has started
    if (characteristic.isNotifying) {
        [delegate connectionChanged:YES];
    } else { // Notification has stopped
        // so disconnect from the peripheral
        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
        [self.manager cancelPeripheralConnection:self.peripheral];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    int i;
    [characteristic.value getBytes:&i length:sizeof(i)];
            [delegate buttonPressed:i];
}

+ (NSData*) dataByIntepretingHexString:(NSString*) hexString {
    char const *chars = hexString.UTF8String;
    NSUInteger charCount = strlen(chars);
    if (charCount % 2 != 0) {
        return nil;
    }
    NSUInteger byteCount = charCount / 2;
    uint8_t *bytes = malloc(byteCount);
    for (int i = 0; i < byteCount; ++i) {
        unsigned int value;
        sscanf(chars + i * 2, "%2x", &value);
        bytes[i] = value;
    }
    return [NSData dataWithBytesNoCopy:bytes length:byteCount freeWhenDone:YES];
}


- (void)send:(NSString *)Message{
    
    NSData *d = [btManager dataByIntepretingHexString:Message];
    [self.peripheral writeValue:d forCharacteristic:txCharacterestic type:CBCharacteristicWriteWithoutResponse];
}

- (void) peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"Error changing notification state: %@", error.localizedDescription);
    NSLog(@"didwriteValue");

}

@end

