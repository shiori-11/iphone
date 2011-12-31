//
//  CounterViewController.h
//  Counter
//
//  Created by 五十島 志織 on H.23/12/25.
//  Copyright (c) 平成23年 東京工科大学大学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

@interface CounterViewController : UIViewController
{
  int count;
  SystemSoundID soundID;
  NSUserDefaults* defaults;
 }
@property (strong, nonatomic) IBOutlet UILabel *display;
- (void)updateDisplay;
- (IBAction)subtract;
- (IBAction)clear;
- (IBAction)add;

@end
