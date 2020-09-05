//
//  PhotoCCell.h
//  donbealbum
//
//  Created by donbe on 2020/9/1.
//  Copyright © 2020 donbe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCCell : UICollectionViewCell

@property(nonatomic,strong)UIImage *photo;
@property(nonatomic,strong)NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
