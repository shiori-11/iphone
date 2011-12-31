//
//  BalanceViewController.m
//  Balance
//
//  Created by 五十島 志織 on H.23/12/31.
//  Copyright (c) 平成23年 東京工科大学大学院. All rights reserved.
//

#import "BalanceViewController.h"

@implementation BalanceViewController
@synthesize ball;
@synthesize flash;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  // 効果音の再生を準備
  NSString *path = [[NSBundle mainBundle] pathForResource:@"Beep" ofType:@"caf"];
  NSURL *url = [NSURL fileURLWithPath:path];
  AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
  
  // 自動ロックの禁止
  UIApplication *application = [UIApplication sharedApplication];
  application.idleTimerDisabled = YES;
  
  // 位置の初期値を設定
  positionX = 160.0;
  positionY = 240.0;
  
  // 速度の初期値を設定
  speedX = 0.0;
  speedY = 0.0;
  
  // 加速度の初期値を設定
  accelX = 0.0;
  accelY = 0.0;
  


#if(TARGET_IPHONE_SIMULATOR)
  // シミュレータ動作時はタイマーを動作
  [NSTimer scheduledTimerWithTimeInterval:0.02
                                   target:self
                                 selector:@selector(akeAccelerometer)
                                 userInfo:nil
                                  repeats:YES ];
  
#else
  // 加速度センサーの利用
  // 加速度センサーのインスタンスを取得
  UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
  // 加速度センサーの値を得る時間間隔を指定
  accelerometer.updateInterval = 0.02;
  // 加速度センサーの値を受け取るデリゲートを自分自身に設定
  accelerometer.delegate = self;
#endif
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
  [self setFlash:nil];
  [self setBall:nil];
  [self setBall:nil];
  [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  
  if (interfaceOrientation == UIInterfaceOrientationPortrait)
    return YES;
  else
    return NO;

}

// ボールが衝突したときに、フレームを光らせるメソッド
- (void)bump
{
  // アルファ値を1.0にして光るフレームを表示
  flash.alpha = 1.0;
  
  // 効果音を鳴らす
  AudioServicesPlayAlertSound(soundID);
  
  // 1秒かけてアルファ値を0.0に変化させる
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:1.0];
  
  flash.alpha = 0.0;
  
  [UIView commitAnimations];
}

- (void)move
{
  // 加速度から速度を計算
  speedX += accelX;
  speedY -= accelY;
  
  // 速度から位置を計算
  positionX += speedX;
  positionY += speedY;
  
  // ボールと左側のフレームとの衝突判定
  if (positionX <= 80)
  {
    // ボールが跳ね返るよう位置の速度と設定
    speedX *= -1;
    positionX = 80 - (80 - positionX);
    // フレームを光らせる
    [self bump];
  }
  
  // ボールと右側のフレームとの衝突判定
  if (positionX >= 240)
  {
    // ボールが跳ね返るよう位置の速度と設定
    speedX *= -1;
    positionX = 240 - (positionX - 240);
    // フレームを光らせる
    [self bump];
  }
  
  // ボールと上側のフレームとの衝突判定
  if (positionY <= 80)
  {
    // ボールが跳ね返るよう位置と速度を設定
    speedY *= -1;
    positionY = 80 + (80 - positionY);
    // フレームを光らせる
    [self bump];
  }
  
  // ボールと下側のフレームとの衝突判定
  if (positionY >= 400)
  {
    // ボールが跳ね返るよう位置と速度を設定
    speedY *= -1;
    positionY = 400 - (positionY - 400);
    // フレームを光らせる
    [self bump];
  }
  
  // 計算した位置にボールを移動
  ball.center = CGPointMake(positionX, positionY);
  
}

- (void)accelerometer:(UIAccelerometer *)accelerometer
  didAccelerate:(UIAcceleration *)acceleration
{
  // 加速度センサーの処理
  // インスタンス変数に加速度の値を代入
  accelX = acceleration.x;
  accelY = acceleration.y;
  accelZ = acceleration.z;
  
  // ボールを移動させる
  [self move];
}

#if(TARGET_IPHONE_SIMULATOR)
- (void)akeAccelerometer
{
  // インスタンス変数に加速度の値を代入
  accelX = 0.01;
  accelY = 0.01;
  accelZ = 0.0;
  
  // ボールを移動させる
  [self move];
}
#endif

@end
