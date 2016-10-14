//
//  RootViewController.m
//  SqueezeBubble
//
//  Created by qianfeng on 15/9/1.
//  Copyright (c) 2015年 JSL. All rights reserved.
//

#import "RootViewController.h"
#import "PlayViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface RootViewController ()

@end

@implementation RootViewController{
    NSString*strsco;
    NSString*fileName;
    PlayViewController*play;
    AVAudioPlayer *player;
    BOOL mui;
}

- (void)viewDidLoad {

    mui=NO;
    
    [_butPlay addTarget:self action:@selector(butPlay_click:) forControlEvents:UIControlEventTouchDown];
    
    NSArray*arr=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*str=arr[0];
    fileName=[str stringByAppendingPathExtension:@"ghost.txt"];
    NSFileManager*fm=[NSFileManager defaultManager];
    BOOL a;
    BOOL b=[fm fileExistsAtPath:fileName isDirectory:&a];
    if (b&&!a) {
        strsco=[NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
         self.labHeightest.text=strsco;
        
    }
    else{

        self.labHeightest.text=@"0";
        strsco=0;
        
    }
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"hellowind" ofType:@"mp3"];
    
    //创建一个play
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:file] error:nil];
    
    [player prepareToPlay];
    [player play];
    player.currentTime=5;
    [self music];

}
//播放音乐的方法
-(void)music{
    
    _tim = [NSTimer scheduledTimerWithTimeInterval:37 target:self selector:@selector(tim_Tick) userInfo:nil repeats:YES];

}
-(void)tim_Tick{
    
    [player play];
    player.currentTime=5;
}
//停止、开始、音乐
- (IBAction)click_muisc:(id)sender {
    
    if (mui) {
        
        [player play];
        player.currentTime=5;
        [self music];
    }
    else{
        
        [player stop];
        [_tim invalidate];
        _tim = nil;
    }
    mui=!mui;
}

//点击_butPlay调用的方法
-(void)butPlay_click:(id)sender{
    play=[[PlayViewController alloc]init];
    play.delegate=self;
    play.highest=self.labHeightest.text;
    [self presentViewController:play animated:YES completion:nil];
}

//协议方法,如果需要把数据写入文件
-(void)returnScore:(NSInteger)score{
    
    strsco=[NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    if ([strsco intValue]<score) {
        
        NSString*str=[NSString stringWithFormat:@"%ld",(long)score];
        self.labHeightest.text=str;
        NSFileHandle *handle=[NSFileHandle fileHandleForUpdatingAtPath:fileName];
        [handle truncateFileAtOffset:0];
        [str writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    play.highest=self.labHeightest.text;
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
