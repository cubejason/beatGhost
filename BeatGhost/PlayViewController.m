//
//  PlayViewController.m
//  SqueezeBubble
//
//  Created by qianfeng on 15/9/1.
//  Copyright (c) 2015年 JSL. All rights reserved.
//

#import "PlayViewController.h"
#import "GhostButton.h"
@interface PlayViewController ()

@end

@implementation PlayViewController{
    NSInteger num;
    GhostButton *but;
    UIAlertView *alertLoadingData;
    UIAlertController*ale;
    
    float time;
    NSInteger sco;
    NSInteger n;
    
}

- (void)viewDidLoad {
    num=0;
    sco=0;
    time=1.6; //制造一个ghost的时间
    _died=0;
    n=3;
    [self gamePlay];
    

}


- (void)gamePlay {
   
    _timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(time_Tick) userInfo:nil repeats:YES];
}

//
- (void) time_Tick {
    CGFloat h=self.view.frame.size.height;
    CGFloat w=self.view.frame.size.width;
    but=[[GhostButton alloc]initWithRect:h :w];
    
    but.click=arc4random()%n+1;
    but.delegate=self;
    but.delegateDied=self;
    [self.view addSubview:but];
    [but getAGhost];

    num+=1;
    
    //一关有几只ghost
    if (num>30) {
        n++;
        [_timer invalidate];
        _timer = nil;
        [self performSelector:@selector(nextPlay) withObject:self afterDelay:11];
    }
}
-(void)nextPlay{
    num=0;
    if (time>0.5) {
        
        time-=0.2;
        
    }else{
        
        time=0.4;
    }
    
    if (_died>=3) {
        
        [_timer invalidate];
        _timer = nil;
    }
    else{
        
    [self showLoadAlert];
    
   //提醒alert出现的时间
    [self performSelector:@selector(hideLoadAlert) withObject:self afterDelay:3];
    
    [self performSelector:@selector(gamePlay) withObject:self afterDelay:3];
    }
}
//两个协议
-(void)getScore:(NSInteger)score{
    sco+=score;
    _labScore.text=[NSString stringWithFormat:@"%ld",(long)sco];
    [self.delegate returnScore:sco];
}
-(void)getDiedSum{
    
    _died++;
    
    //走了几只ghost，输了
    if (_died>=3) {
        
        NSArray  *arr= self.view.subviews;
        for (id but1 in arr) {
            if ([but1 isKindOfClass:[GhostButton class]]) {
                GhostButton *gho=but1;
                gho.isRunning=NO;
                [gho removeFromSuperview];
                gho.y=1000;
            }
        }
 
        [self trayAgain];

    }
}
//一局结束会出现的alert
-(void)trayAgain{
    [_timer invalidate];
    _timer = nil;
    ale=[UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"你失败了\n\n得分 %ld",(long)sco] message:[NSString stringWithFormat:@"\n最高分 %@",_highest] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*act=[UIAlertAction actionWithTitle:@"主界面" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
     UIAlertAction*act1=[UIAlertAction actionWithTitle:@"再来一次" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        _labScore.text=@"0";
         [self gameOver];
     }];
    
    [ale addAction:act];
    [ale addAction:act1];
    
    [self presentViewController:ale animated:YES completion:nil];
    
    
}
-(void)gameOver{
    num=0;
    time=2;
    sco=0;
    _died=0;
    n=3;
    [self gamePlay];
}
//两个ALERT
- (void) showLoadAlert{
    if (alertLoadingData == nil) {
        alertLoadingData = [[UIAlertView alloc] initWithTitle:@"下一关" message:@"时间加快0.2s" delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    }
    
    [alertLoadingData show];

}
//自动隐藏Alert
- (void) hideLoadAlert{
    if (alertLoadingData != nil) {
        [alertLoadingData dismissWithClickedButtonIndex:0 animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
