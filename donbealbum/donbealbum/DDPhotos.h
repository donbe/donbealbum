//
//  DDPhotos.h
//  donbealbum
//
//  Created by donbe on 2020/9/2.
//  Copyright © 2020 donbe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDPhotos : NSObject

//自定义相册
+(PHFetchResult<PHAssetCollection *> *)albums;

// 相机胶卷
+(PHAssetCollection *)cameraRoll;

// 从某个相册中获取图片资源
+(PHFetchResult<PHAsset *> *)photosInAlbum:(PHAssetCollection *)collection;

// 获取图片
+(void)imageInAsset:(PHAsset *)asset original:(BOOL)original callback:(void(^)(UIImage * _Nullable result, NSDictionary * _Nullable info))callback;

@end

NS_ASSUME_NONNULL_END
