//
//  GhostButton.h
//  BeatGhost
//
//  Created by qianfeng on 15/9/4.
//  Copyright (c) 2015年 JSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "getScore.h"
#import "getDiedSum.h"
@interface GhostButton : UIButton
-(void)getAGhost;
-(id)initWithRect:(float)heigh :(float)wide;
@property NSInteger score;
@property id<getScore>delegate;
@property id<getDiedSum>delegateDied;
@property NSInteger y;
@property BOOL isRunning;
@property NSInteger click;;
@end
