//
//  DDPhotos.m
//  donbealbum
//
//  Created by donbe on 2020/9/2.
//  Copyright © 2020 donbe. All rights reserved.
//

#import "DDPhotos.h"


@implementation DDPhotos

+(PHFetchResult<PHAssetCollection *> *)albums{
    return  [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];

}

+(PHAssetCollection *)cameraRoll{
    return [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
}


+(PHFetchResult<PHAsset *> *)photosInAlbum:(PHAssetCollection *)collection{
    return [PHAsset fetchAssetsInAssetCollection:collection options:nil];
}

+(void)imageInAsset:(PHAsset *)asset original:(BOOL)original callback:(void(^)(UIImage * _Nullable result, NSDictionary * _Nullable info))callback{
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
//    options.synchronous = YES; // 同步获得图片
    options.networkAccessAllowed = YES;
    
    // 是否要原图
    CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
    
    // 从asset中获得图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        callback(result,info);
    }];
}

@end
