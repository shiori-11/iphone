//
//  SmashViewController.h
//  Smash
//
//  Created by 五十島 志織 on H.23/12/25.
//  Copyright (c) 平成23年 東京工科大学大学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SmashViewController : UIViewController
{
  IBOutlet UIButton *target; // 目標（UFO)
  SystemSoundID soundID; // 効果音
  int count;
  int flag;
  int timeCount;
  
  IBOutlet UILabel *laber;  
  IBOutlet UILabel *second;
  
  IBOutlet UIButton *startButton;
  IBOutlet UIButton *rankButton;
  
  NSTimer *tm;
}
- (IBAction)smash; //UFOがタッチされたとき
- (void)move:(NSTimer *)timer;  // タイマーから呼び出される

- (IBAction)gameStart;
- (IBAction)ranking;

@end
