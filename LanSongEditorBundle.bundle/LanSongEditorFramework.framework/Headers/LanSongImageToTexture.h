//
//  LanSongImageToTexture.h
//  LanSongEditorFramework
//
//  Created by sno on 2017/10/26.
//  Copyright © 2017年 sno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LanSongOutput.h"
#import <AVKit/AVKit.h>

/**
 在VideoProcessQueue建立后, 调用initWith可以拿到
 纹理和缩放后到纹理中的图片大小(图层宽高)
 
 */
@interface LanSongImageToTexture : NSObject
{
    UIImage *imageSource;
    GLuint outputTexture;
}

/**
 放入到OpenGL里的图像尺寸, 如果尺寸大于GPU支持的最大尺寸,则大的数组等于最大尺寸,小的缩放.
 如果不大于,则直接等于原有大小.
 */
//@property CGSize pixelSizeOfImage;

-(GLuint)getTexture;


/**
 拿到的纹理, 只有Texture, 没有FBO;
 */
//@property LanSongFramebuffer *outputFramebuffer;


/**
 初始化

 @param newImageSource <#newImageSource description#>
 @return <#return value description#>
 */
- (id)initWithCGImage:(UIImage *)newImageSource activeId:(int)activeId;

@end
