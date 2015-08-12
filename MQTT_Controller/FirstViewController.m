//
//  FirstViewController.m
//  MQTT_Controller
//
//  Created by Bodhi Connolly on 25/01/2015.
//  Copyright (c) 2015 Bodhi Connolly. All rights reserved.
//

#import "FirstViewController.h"

#define sleepTopic @"room/function/sleep"
#define fadeTopic @"room/function/fade"
#define stopTopic @"room/function/stop"
#define ledTopic @"room/lights/strips"


@interface FirstViewController ()

@property NSDate*lastSend;
@property NSTimeInterval(waitTime);

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _waitTime=0.01;
    _lastSend=[NSDate date];
    _timeText.delegate=self;
    _topicText.delegate=self;
    _messageText.delegate=self;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendButton:(id)sender {
    [self.topicText resignFirstResponder];
    [self.messageText resignFirstResponder];
    [[MQTTSender sharedMQTT] sendMessage:_messageText.text topic:_topicText.text];
}
- (IBAction)sleepButton:(id)sender {
    [self.timeText resignFirstResponder];
    [[MQTTSender sharedMQTT] sendMessage:_timeText.text topic:sleepTopic];
}
- (IBAction)fadeButton:(id)sender {
    [self.timeText resignFirstResponder];
    [[MQTTSender sharedMQTT] sendMessage:_timeText.text topic:fadeTopic];
}
- (IBAction)stopButton:(id)sender {
    [self.timeText resignFirstResponder];
    [self.messageText resignFirstResponder];
    [self.topicText resignFirstResponder];

    [[MQTTSender sharedMQTT] sendMessage:_timeText.text topic:stopTopic];
}
- (IBAction)redSlider:(id)sender {
    NSTimeInterval timeInterval = fabs([_lastSend timeIntervalSinceNow]);
    if ((timeInterval>_waitTime)){
    [[MQTTSender sharedMQTT] sendMessage:[@((int)_redSlider.value) stringValue] topic:[ledTopic stringByAppendingString:@"/r"]];
    }
    _lastSend=[NSDate date];
}
- (IBAction)greenSlider:(id)sender {
        [[MQTTSender sharedMQTT] sendMessage:[@((int)_greenSlider.value) stringValue] topic:[ledTopic stringByAppendingString:@"/g"]];
}
- (IBAction)blueSlider:(id)sender {
        [[MQTTSender sharedMQTT] sendMessage:[@((int)_blueSlider.value) stringValue] topic:[ledTopic stringByAppendingString:@"/b"]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
