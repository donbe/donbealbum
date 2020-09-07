//
//  DDUploader.m
//  donbealbum
//
//  Created by donbe on 2020/9/5.
//  Copyright © 2020 donbe. All rights reserved.
//

#import "DDUploader.h"
#import "OSSModel.h"
#import "OSSClient.h"


@implementation DDUploader

+ (void)exportVideo:(PHAsset * _Nonnull)asset {
    PHVideoRequestOptions *videoOptions = [PHVideoRequestOptions new];
    videoOptions.networkAccessAllowed = YES;                                        // 如果图片存在icloud上，那么允许先下载
    videoOptions.version = PHVideoRequestOptionsVersionCurrent;                     // 如果视频编辑过，返回编辑过的
    videoOptions.deliveryMode = PHVideoRequestOptionsDeliveryModeHighQualityFormat; // 获取最高质量的，牺牲速度
    
    [[PHImageManager defaultManager] requestExportSessionForVideo:asset options:videoOptions exportPreset:AVAssetExportPresetHighestQuality resultHandler:^(AVAssetExportSession * _Nullable exportSession, NSDictionary * _Nullable info) {
        
        exportSession.outputURL = [NSURL URLWithString:@""]; // 导出本地路径
        exportSession.shouldOptimizeForNetworkUse = YES; // 对网络传输进行优化
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch (exportSession.status) {
                case AVAssetExportSessionStatusCompleted:
                    
                    break;
                    
                default:
                    break;
            }
        }];
    }];
}

+ (void)exportImage:(PHAsset * _Nonnull)asset {
    PHImageRequestOptions *imageOptions = [PHImageRequestOptions new];
    imageOptions.networkAccessAllowed = YES;                        // 如果图片存在icloud上，那么允许先下载
    imageOptions.version =  PHImageRequestOptionsVersionCurrent;    // 如果图片编辑过，返回编辑过的图片
    imageOptions.resizeMode = PHImageRequestOptionsResizeModeFast;  // 可能和指定的图片尺寸有点点出入，但是速度快
    
    [[PHImageManager defaultManager] requestImageDataAndOrientationForAsset:asset options:imageOptions resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, CGImagePropertyOrientation orientation, NSDictionary * _Nullable info) {
        
    }];
}

+(void)uploadAsset:(PHAsset *)asset{
    
    NSString *name = asset.localIdentifier;
    NSString *prefix = [self datePrefixFromDate:asset.creationDate];
    
    switch (asset.mediaType) {
        case PHAssetMediaTypeAudio:
        case PHAssetMediaTypeVideo:
            // 音视频
            [self exportVideo:asset];
            break;
        case PHAssetMediaTypeImage:
            // 图片
            [self exportImage:asset];
            break;
        default:
            assert(0);
            break;
    }
}

    
+(void)uploadData:(NSData *)data filename:(NSString *)filename{
    
    NSString *endpoint = @"http://oss-cn-hangzhou.aliyuncs.com";
    // 由阿里云颁发的AccessKeyId/AccessKeySecret构造一个CredentialProvider。
    // 推荐使用OSSAuthCredentialProvider，token过期后会自动刷新。
    
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:@"LTAI4GHxcvojo6r87qCKfBLD" secretKeyId:@"FjFoBhYwq2hIIiRI1zEIO1tXuxketG" securityToken:nil];
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
        
    
    
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    // 配置必填字段，其中bucketName为存储空间名称；objectKey等同于objectName，表示将文件上传到OSS时需要指定包含文件后缀在内的完整路径，例如abc/efg/123.jpg。
    put.bucketName = @"donbe";
    put.objectKey = filename;
//    put.uploadingFileURL = [NSURL fileURLWithPath:@"<filepath>"];
     put.uploadingData = data;
    // 配置可选字段。
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 指定当前上传长度、当前已经上传总长度、待上传的总长度。
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    // 配置可选字段。
    // put.contentType = @"";
    // put.contentMd5 = @"";
    // put.contentEncoding = @"";
    // put.contentDisposition = @"";
    // 可以在上传文件时设置元信息或者HTTP头部。
    // put.objectMeta = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value1", @"x-oss-meta-name1", nil];
    OSSTask * putTask = [client putObject:put];
//    [putTask continueWithBlock:^id(OSSTask *task) {
//        if (!task.error) {
//            NSLog(@"upload object success!");
//        } else {
//            NSLog(@"upload object failed, error: %@" , task.error);
//        }
//        return nil;
//    }];
}

+(NSString *)datePrefixFromDate:(NSDate *)date{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"/yyyy/MM/dd/"];
    
    return [dateFormatter stringFromDate:currentDate];
}

@end
