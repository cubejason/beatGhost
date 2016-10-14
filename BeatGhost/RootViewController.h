//
//  RootViewController.h
//  SqueezeBubble
//
//  Created by qianfeng on 15/9/1.
//  Copyright (c) 2015年 JSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "returnScore.h"
@interface RootViewController : UIViewController<returnScore>
@property (weak, nonatomic) IBOutlet UIButton *butPlay;
@property (weak, nonatomic) IBOutlet UIButton *butQuit;
@property (weak, nonatomic) IBOutlet UILabel *labHeightest;
@property NSTimer *tim;


@end
