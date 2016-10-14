//
//  GhostButton.m
//  BeatGhost
//
//  Created by qianfeng on 15/9/4.
//  Copyright (c) 2015年 JSL. All rights reserved.
//

#import "GhostButton.h"
#import "PlayViewController.h"
@implementation GhostButton{

    float x;
    
    float vx;
    float vy;
    float width;
    float height;
    
NSInteger t;
    
}
-(id)initWithRect:(float)heigh :(float)wide{
    if (self=[super init]) {
        width=wide;
        height=heigh;
      
        x=arc4random()%4*50+width/4;
        _y =height-30-arc4random()%100;
        t=0;
        _isRunning = NO;
     
        [self setImage:[UIImage imageNamed:@"hjfc"] forState:UIControlStateNormal];
        self.frame = CGRectMake(x, _y, 35, 35);
        
        [self addTarget:self action:@selector(click_container:) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}
//点击图片
-(void)click_container:(id)sender{
    _click--;
    if (_click==0) {
        [self.delegate getScore:(arc4random()%2+1)];
        
        [self removeFromSuperview];
        _y=1000;
        _isRunning=NO;
    }

}
//控制ghost的位置,每隔一段时间调用一次函数
- (void)getAGhost {
    if (_isRunning) {
        _isRunning = NO;
    }
    else {
        _isRunning = YES;
        
        [self performSelector:@selector(imgObject_Run) withObject:nil afterDelay:0.1f];
    }
}


- (void)imgObject_Run{
    
    //要回调是有条件的
    if (_isRunning) {
        
        vx=arc4random()%10+arc4random()%5+5;
      
        float f=arc4random()%5;
        vy=-(f+10);
       
        switch (arc4random()%2) {
            case 0:
                break;
            case 1:
                vx=-vx;
                break;
            default:
                break;
        }
        if (x<25) {
            if (vx>0) {
                
            }else{
                vx=-vx;
            }
        }
        if (x>width-25) {
            if (vx<0) {
                
            }else{
                vx=-vx;
            }
        }

        x += vx;
        _y += vy;
        
        self.frame = CGRectMake(x, _y, 35, 35);
        
        if (_y<10) {
            
            _isRunning=NO;
            
            [self removeFromSuperview];
        
            [self.delegateDied getDiedSum];
        }

        [self performSelector:@selector(imgObject_Run) withObject:nil afterDelay:0.2f];
    }
}

@end
