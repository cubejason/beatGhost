//
//  PlayViewController.h
//  SqueezeBubble
//
//  Created by qianfeng on 15/9/1.
//  Copyright (c) 2015年 JSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "getScore.h"
#import "getDiedSum.h"
#import "returnScore.h"
@interface PlayViewController : UIViewController<getScore,getDiedSum>

@property (weak, nonatomic) IBOutlet UILabel *labScore;
@property NSInteger died;
@property NSTimer *timer;
@property id<returnScore>delegate;
@property NSString *highest;

@end
