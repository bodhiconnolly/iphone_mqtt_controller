//
//  MQTTSender.h
//  MQTT_Controller
//
//  Created by Bodhi Connolly on 25/01/2015.
//  Copyright (c) 2015 Bodhi Connolly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQTTKit.h"

@interface MQTTSender : NSObject

+ (MQTTSender *)sharedMQTT;

- (void)sendMessage:(NSString*)payload topic:(NSString*)topic;

- (BOOL)connect;

-(void)subscribe:(NSString*)topic;

@property (nonatomic, strong) MQTTClient *client;


@end
