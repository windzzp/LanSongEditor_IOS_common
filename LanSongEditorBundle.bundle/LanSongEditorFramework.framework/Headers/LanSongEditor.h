//
//  LanSongEditor.h
//  LanSongEditor
//
//  Created by sno on 16/8/3.
//  Copyright © 2016年 sno. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for LanSongEditor.
FOUNDATION_EXPORT double LanSongEditorVersionNumber;

//! Project version string for LanSongEditor.
FOUNDATION_EXPORT const unsigned char LanSongEditorVersionString[];


//滤镜
#import <LanSongEditorFramework/LanSong.h>

//视频的剪切, 裁剪, logo, 文字,滤镜,缩放,码率, 压缩的一次性处理
#import <LanSongEditorFramework/LSOVideoOneDo.h>

//获取音视频的信息;
#import <LanSongEditorFramework/LSOMediaInfo.h>

//创建各种临时文件的头文件
#import <LanSongEditorFramework/LSOFileUtil.h>

//视频的:加减速, 调整帧率, 镜像, 旋转,倒序,删除logo,等所有的ffmpeg来显示的功能, 在这里.
#import <LanSongEditorFramework/LSOVideoEditor.h>


//音频容器;
#import <LanSongEditorFramework/AudioPadExecute.h>

//导入视频
#import <LanSongEditorFramework/LSOEditMode.h>
@interface LanSongEditor : NSObject

/**
  获取当前sdk的限制时间中的年份.
 */
+(int)getLimitedYear;

/**
 获取当前sdk的限制时间中的月份

 @return
 */
+(int)getLimitedMonth;

/**
 返回当前sdk的版本号.

 @return
 */
+(NSString *)getVersion;
/**
 初始化sdk,

 @return
 */
+(BOOL)initSDK:(NSString *)name;

/**
 使用完毕sdk后, 注销sdk, 
 (当前内部执行为空,可以不调用. 仅预留)
 */
+(void)unInitSDK;



/**
 设置内部文件创建在哪个文件夹下;
 
 如果不设置,默认在当前Document/lansongBox下;
 举例:
 NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
 NSString *documentsDirectory =[paths objectAtIndex:0];
 NSString *tmpDir = [documentsDirectory stringByAppendingString:@"/box2"];
 [LanSongFileUtil setGenTempFileDir:tmpDir];
 
 建议在initSDK的时候设置;
 */
+(void)setTempFileDir:(NSString *)path;
@end
