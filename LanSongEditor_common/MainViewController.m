//
//  MainViewController.m
//  LanSongEditor_all
//
//  Created by sno on 16/12/12.
//  Copyright © 2016年 sno. All rights reserved.
//

#import "MainViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

#import "LanSongUtils.h"
#import "UIColor+Util.h"
#import "Masonry.h"
#import "LSOLocalVideoVC.h"
#import "LSOFullWidthButtonsView.h"
#import "CommonEditVC.h"

@interface MainViewController () <LSOFullWidthButtonsViewDelegate>
{
    UILabel *labPath; // 视频路径.
    NSArray *functionsArray;
}
@end



@implementation MainViewController
{
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"蓝松视频SDK-基本版";
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    /*
     初始化SDK
     */
     if([LanSongEditor initSDK:nil]==NO){
        [LanSongUtils showDialog:@"SDK已经过期,请更新到最新的版本/或联系我们:"];
     }else{
//         [self showSDKInfo];
     }
    /*
     删除sdk中所有的临时文件.
     */
    [LSOFileUtil deleteAllSDKFiles];
    functionsArray=@[
                     @"1.背景音乐/裁剪/缩放/压缩/logo等10个功能>>",
                     @"2.加减速",
                     @"3.旋转90度",
                     @"4.删除logo",
                     @"5.调整帧率",
                     @"6.倒序",
                     @"7.镜像",
                     @"8.多个视频画面拼接",
                     @"9.多个视频时长拼接",
                     @"10.单张图片变视频",
                     @"11.多张图片变视频",
                     @"12.视频转Gif",
                     @"13.自定义扩展",
                     @"14.直接播放视频"];
    [self initView];
    [self testFile];
}
/**
 各种功能点击后,走到这里.
 */
- (void)LSOFullWidthButtonsViewSelected:(int)index
{
    if(index==0){  //0是10个功能列表;
        UIViewController *pushVC=[[CommonEditVC alloc] init];
        [self.navigationController pushViewController:pushVC animated:YES];
    }else if(index==(int)functionsArray.count-1){  //直接播放;
          [LanSongUtils startVideoPlayerVC:self.navigationController dstPath:[AppDelegate getInstance].currentEditVideo];
    }else{
        [LanSongUtils showDialog:@"暂时没有写演示,请直接运行LSOVideEditor类中对应代码."];
    }
}
- (void)viewDidAppear:(BOOL)animated
{
     [LanSongUtils setViewControllerPortrait];
}
/**
 点击后, 进去界面.
 */
-(void)onClicked:(UIView *)sender
{
    
    if (sender.tag==101) {
        NSString *defaultVideo=@"dy_xialu2";
        NSURL *sampleURL = [[NSBundle mainBundle] URLForResource:defaultVideo withExtension:@"mp4"];
        if(sampleURL!=nil){
            labPath.text=[NSString stringWithFormat:@"使用默认视频:%@",defaultVideo];
            [AppDelegate getInstance].currentEditVideo=[LSOFileUtil urlToFileString:sampleURL];
        }else{
            [LanSongUtils showDialog:@"选择默认视频  ERROR!!"];
        }
        sender.backgroundColor=[UIColor greenColor];
    }else if(sender.tag==102){
        sender.backgroundColor=[UIColor yellowColor];
        UIViewController  *pushVC2=[[LSOLocalVideoVC alloc] init];
        [self.navigationController pushViewController:pushVC2 animated:YES];
    }else{
        LSOLog(@"error  on clicked..");
    }
}


-(void)initView
{
    UIView *topView=[self newDefaultButton];
    LSOFullWidthButtonsView *scrollView=[LSOFullWidthButtonsView new];
    [self.view  addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];

    scrollView.delegate=self;
    [scrollView configureView:functionsArray width:self.view.frame.size.width];
    
}
-(UIView *)newDefaultButton
{
    
    CGFloat heightOffset=self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    NSLog(@"navigationbar height: %f", heightOffset);
    
    UIButton *btn1=[[UIButton alloc] init];
    btn1.tag=101;
    
    [btn1 setTitle:@"使用默认视频" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn1.backgroundColor=[UIColor greenColor];
    
    [btn1 addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn1];
    
    UIButton *btn2=[[UIButton alloc] init];
    btn2.tag=102;
    
    [btn2 setTitle:@"文件夹" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn2.backgroundColor=[UIColor yellowColor];
    
    [btn2 addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn2];
    
    
    labPath=[[UILabel alloc] init];
    labPath.text=@"请选择视频文件.";
    labPath.textColor=[UIColor redColor];
    
    [self.view addSubview:labPath];
    
    CGSize size=self.view.frame.size;
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).offset(heightOffset+5);
            make.left.mas_equalTo(self.view.mas_left).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(size.width*0.7f-20, 50));  //按钮的高度.
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(heightOffset+5);
        make.left.mas_equalTo(size.width*0.7f);
        make.size.mas_equalTo(CGSizeMake(size.width*0.25f, 50));  //按钮的高度.
    }];
    
    [labPath mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn1.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.view.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(size.width, 30));  //按钮的高度.
    }];
    
    return labPath;
}
-(void)showSDKInfo
{
    NSString *available=[NSString stringWithFormat:@"当前版本:%@, 到期时间是:%d 年 %d 月之前",[LanSongEditor getVersion],
                         [LanSongEditor getLimitedYear],[LanSongEditor getLimitedMonth]];
    [LanSongUtils showDialog:available];  //显示对话框.
}
-(void)btnDown:(UIView *)sender
{
    sender.backgroundColor=[UIColor grayColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//是否自动旋转,返回YES可以自动旋转
- (BOOL)shouldAutorotate {
    return YES;
}
//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


-(void)testFile
{
    NSString *defaultVideo=@"dy_xialu2";
    NSURL *sampleURL = [[NSBundle mainBundle] URLForResource:defaultVideo withExtension:@"mp4"];
    if(sampleURL!=nil){
        labPath.text=[NSString stringWithFormat:@"使用默认视频:%@",defaultVideo];
        [AppDelegate getInstance].currentEditVideo=[LSOFileUtil urlToFileString:sampleURL];
    }else{
        [LanSongUtils showDialog:@"选择默认视频  ERROR!!"];
    }
}
@end
