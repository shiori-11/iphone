//
//  CounterAppDelegate.h
//  Counter
//
//  Created by 五十島 志織 on H.23/12/25.
//  Copyright (c) 平成23年 東京工科大学大学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CounterViewController;

@interface CounterAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CounterViewController *viewController;

@end
