//
//  SmashViewController.m
//  Smash
//
//  Created by 五十島 志織 on H.23/12/25.
//  Copyright (c) 平成23年 東京工科大学大学院. All rights reserved.
//

#import "SmashViewController.h"

@implementation SmashViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  // 効果音の準備
  NSString *path = [[NSBundle mainBundle] pathForResource:@"Smash" ofType:@"caf"];
  NSURL *url = [NSURL fileURLWithPath:path];
  AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
  flag = 0;

  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
  laber = nil;
  startButton = nil;
  rankButton = nil;
  second = nil;
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
  if (interfaceOrientation == UIInterfaceOrientationPortrait ||
      interfaceOrientation == UIInterfaceOrientationPortrait)
    return YES;
  else
      return NO;
}

// タイマーから呼び出されるメソッド
- (void)move:(NSTimer *)timer
{
  timeCount --;
  if (timeCount == 0){
    [tm invalidate];
    //[startButton setTitle:@"Game Start" forState:UIControlStateNormal];
    startButton.frame = CGRectMake(85, 244, 150, 37);
    rankButton.frame = CGRectMake(118, 318, 84, 37);
    return;
  }
  
  second.text = [NSString stringWithFormat:@"%03d", timeCount / 2];

  // アニメーションの定義開始
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:timer.timeInterval];
  
  // UFO を移動
  int width = self.view.bounds.size.width;
  int height = self.view.bounds.size.height;
  int x = rand() % width;
  int y = rand() % height;
  target.center = CGPointMake(x, y);
  
  // アニメーションの定義終了、実行
  [UIView commitAnimations];
}

- (IBAction)smash
{
  // 効果音を再生
  //AudioServicesPlaySystemSound(soundID);
  // バイブレーション付きで効果音を再生
  AudioServicesPlayAlertSound(soundID);
  // バイブレーションを発生
  //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
  
  count ++;
  laber.text = [NSString stringWithFormat:@"%06d", count];
}

- (IBAction)gameStart {
  double timeInterval;
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    timeInterval = 0.65;  // iPadの場合
  else
    timeInterval = 0.5;   // iPhoneの場合

  if ([startButton.currentTitle isEqualToString:@"Game Start"]){
    //[startButton setTitle:@"" forState:UIControlStateNormal];   // からボタン
    startButton.frame = CGRectMake(0, 0, 0, 0);
    rankButton.frame = CGRectMake(0, 0, 0, 0);
    
    timeCount = 120;
    // UFO の初期位置
    target.center = CGPointMake(100, 200);
    // 乱数の初期化
    srand(time(NULL));
    // タイマーの作成（動作開始）
    tm = [NSTimer scheduledTimerWithTimeInterval:timeInterval               // 時間間隔（秒）
                                          target:self              // 呼び出すオブジェクト
                                        selector:@selector(move:)  // 呼び出すメソッド
                                        userInfo:nil               // ユーザ利用の情報オブジェクト
                                         repeats:YES];             // 繰り返し
  } 
}

- (IBAction)ranking {
}
@end
