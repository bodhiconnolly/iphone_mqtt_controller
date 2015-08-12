//
//  FirstViewController.h
//  MQTT_Controller
//
//  Created by Bodhi Connolly on 25/01/2015.
//  Copyright (c) 2015 Bodhi Connolly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQTTSender.h"

@interface FirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *messageText;
@property (weak, nonatomic) IBOutlet UITextField *topicText;
@property (weak, nonatomic) IBOutlet UITextField *timeText;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;


@end

@interface YourViewController : UIViewController <UITextFieldDelegate>
@end