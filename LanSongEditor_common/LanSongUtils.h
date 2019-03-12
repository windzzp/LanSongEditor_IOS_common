//
//  LanSongUtils.h
//  LanSongEditor_all
//
//  Created by sno on 16/12/19.
//  Copyright © 2016年 sno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "AppDelegate.h"



//接下来3个demo UI部分使用, 您可以直接删除.
#import "MBProgressHUD.h"
#import "Masonry.h"
#import "UIColor+Util.h"
#import "VideoPlayViewController.h"
#import "LSOProgressHUD.h"







#define DEVICE_BOUNDS [[UIScreen mainScreen] applicationFrame]
#define DEVICE_SIZE [[UIScreen mainScreen] applicationFrame].size
#define DEVICE_OS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define DELTA_Y (DEVICE_OS_VERSION >= 7.0f? 20.0f : 0.0f)

#define color(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define VIDEO_FOLDER @"videos"

#define LSOWS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


@interface LanSongUtils : NSObject

+(void)showDialog:(NSString *)str;

+(void) showHUDToast:(NSString *)strHint;

+(void)startVideoPlayerVC:(UINavigationController*)nav dstPath:(NSString *)dstPath;


//20170522++
+ (void)setView:(UIView *)view toSizeWidth:(CGFloat)width;
+ (void)setView:(UIView *)view toOriginX:(CGFloat)x;
+ (void)setView:(UIView *)view toOriginY:(CGFloat)y;
+ (void)setView:(UIView *)view toOrigin:(CGPoint)origin;

+ (BOOL)createVideoFolderIfNotExist;
+ (NSString *)getVideoSaveFilePathString;
+ (NSString *)getVideoMergeFilePathString;
+ (NSString *)getVideoSaveFolderPathString;




/**
设置当前viewController竖屏
 */
+(void)setViewControllerPortrait;

/**
 设置当前viewController横屏
 */
+(void)setViewControllerLandscape;
/**
 在ViewController中调用, 设置当前屏幕的旋转角度.
 */
+ (void)interfaceOrientation:(UIInterfaceOrientation)orientation;
    
@end
