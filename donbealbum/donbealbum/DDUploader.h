//
//  DDUploader.h
//  donbealbum
//
//  Created by donbe on 2020/9/5.
//  Copyright © 2020 donbe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDUploader : NSObject

+(void)uploadAsset:(PHAsset *)asset;

@end

NS_ASSUME_NONNULL_END
