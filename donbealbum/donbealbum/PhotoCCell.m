//
//  PhotoCCell.m
//  donbealbum
//
//  Created by donbe on 2020/9/1.
//  Copyright © 2020 donbe. All rights reserved.
//

#import "PhotoCCell.h"
#import "Masonry.h"

@interface PhotoCCell()

@property(nonatomic,strong)UIImageView *imagev;

@end

@implementation PhotoCCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imagev];
        [self.imagev mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;;
}

#pragma mark - get/set
-(void)setPhoto:(UIImage *)photo{
    [self.imagev setImage:photo];
}

-(UIImageView *)imagev{
    if (_imagev == nil) {
        _imagev = [UIImageView new];
        _imagev.contentMode = UIViewContentModeScaleAspectFill;
        _imagev.layer.masksToBounds = YES;
    }
    return _imagev;
}
@end
