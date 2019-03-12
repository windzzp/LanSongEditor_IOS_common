//
//  LanSongMosaicRectFilter.h
//  LanSongEditorFramework
//
//  Created by sno on 2019/1/7.
//  Copyright © 2019 sno. All rights reserved.
//
#import "LanSongFilter.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanSongMosaicRectFilter  : LanSongFilter


/**
 马赛克的大小; 默认0.08
 */
@property(readwrite, nonatomic) CGFloat fractionalWidthOfAPixel;


/**
 马赛克的区域.
 范围是0.0---1.0;
 
 */
@property(readwrite, nonatomic) CGRect mosaicRect;

@end
NS_ASSUME_NONNULL_END

