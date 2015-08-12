//
//  MQTTSender.m
//  MQTT_Controller
//
//  Created by Bodhi Connolly on 25/01/2015.
//  Copyright (c) 2015 Bodhi Connolly. All rights reserved.
//

#import "MQTTSender.h"
#import "MQTTKit.h"

#define homeMQTT @"home.bodhiconnolly.com"
#define testTopic @"test"
#define clientID @"BC_iPhone"
#define subscribeTopic @"ios"

@implementation MQTTSender

static MQTTSender *sharedMQTTSender = nil;    // static instance variable

+ (MQTTSender *)sharedMQTT {
    if (sharedMQTTSender == nil) {
        sharedMQTTSender = [[super allocWithZone:NULL] init];
    }
    return sharedMQTTSender;
}

- (void)sendMessage:(NSString*)payload topic:(NSString*)topic{
    [self.client publishString:payload
                       toTopic:topic
                       withQos:0
                        retain:NO
             completionHandler:nil];

}

- (id)init {
    if ( (self = [super init]) ) {
        // your custom initialization
        [self connect];
    }

    return self;
}

-(BOOL)connect {
    self.client = [[MQTTClient alloc] initWithClientId:clientID];
    __block bool connected = 0;
    
    // define the handler that will be called when MQTT messages are received by the client
    [self.client setMessageHandler:^(MQTTMessage *message) {
        // extract the switch status from the message payload
        NSString*payload=[[NSString alloc] initWithData:message.payload encoding:NSUTF8StringEncoding];
        // the MQTTClientDelegate methods are called from a GCD queue.
        // Any update to the UI must be done on the main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            [self parseIncoming:payload];
        });
    }];

    
    [self.client connectToHost:homeMQTT completionHandler:^(MQTTConnectionReturnCode code) {
        if (code == ConnectionAccepted) {
            [self subscribe:subscribeTopic];
            NSLog(@"Connected with id %@", clientID);
            connected = 1;
    }else{
        connected=0;
    }}];
    return connected;
}

    

-(void)subscribe:(NSString*)topic{
    [self.client subscribe:subscribeTopic withCompletionHandler:^(NSArray *grantedQos) {
        // The client is effectively subscribed to the topic when this completion handler is called
        NSLog(@"subscribed to topic %@", subscribeTopic);
    }];
}

- (void)parseIncoming:(NSString*)payload{
    dispatch_async(dispatch_get_main_queue(), ^{
        //Parse and act on message here
        NSLog(@"Incoming %@", payload);
    });

}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


@end
