//
//  CounterViewController.m
//  Counter
//
//  Created by 五十島 志織 on H.23/12/25.
//  Copyright (c) 平成23年 東京工科大学大学院. All rights reserved.
//

#import "CounterViewController.h"


@implementation CounterViewController
@synthesize display;

- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  // NSUserDefaults インスタンスを準備します。
  defaults = [NSUserDefaults standardUserDefaults];
  count = [defaults integerForKey:@"count"];
  display.text = [NSString stringWithFormat:@"%04d", count];

      [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setDisplay:nil];
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

- (void)sounde:(NSString *)soundName
{
  NSString *path = [[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"];
  NSURL *url = [NSURL fileURLWithPath:path];
  AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)url, &soundID);
}

// 保存
- (void) save
{
  // count を書き込み
  [defaults setInteger:count forKey:@"count"];
  // 反映させる
  [defaults synchronize];
}

- (void)updateDisplay
{
  if ((count % 10) == 0)
    [self sounde:@"cancel5"];
  AudioServicesPlaySystemSound(soundID);
  [self save];
  display.text = [NSString stringWithFormat:@"%04d", count];
}

- (IBAction)subtract {
  [self sounde:@"decide17"];
  count --;
  if (count <0)
    count = 0;
  [self updateDisplay];
}

- (IBAction)clear {
  [self sounde:@"cancel4"];
  count = 0;
  [self updateDisplay];
}

- (IBAction)add {
  [self sounde:@"decide20"];
  count ++;
  [self updateDisplay];
}
@end
