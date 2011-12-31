//
//  BalanceViewController.h
//  Balance
//
//  Created by 五十島 志織 on H.23/12/31.
//  Copyright (c) 平成23年 東京工科大学大学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface BalanceViewController : UIViewController <UIAccelerometerDelegate>
{
  double accelX, accelY, accelZ;    // 加速度
  double speedX, speedY;    // 速度
  double positionX, positionY;    // 位置
  SystemSoundID soundID;  // 効果音
}

- (void)move; // ボールを移動させるメソッド
- (void)bump; // ボールが衝突したときに、フレームを光らせるメソッド

@property (strong, nonatomic) IBOutlet UIImageView *ball;
@property (strong, nonatomic) IBOutlet UIImageView *flash;

@end
