//
//  ViewController.m
//  donbealbum
//
//  Created by donbe on 2020/8/31.
//  Copyright © 2020 donbe. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "PhotoCCell.h"
#import "GlobalMacro.h"
#import "DDPhotos.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)NSMutableArray *photoArray;
@property(nonatomic,strong)UICollectionView *showPhotoCollectionView;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;

@property(nonatomic,strong)PHFetchResult<PHAsset *> *photos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photos = [DDPhotos photosInAlbum:[DDPhotos cameraRoll]];
    [self.showPhotoCollectionView reloadData];
}

    
#pragma –
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PhotoCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];
    cell.indexPath = indexPath;
    [DDPhotos imageInAsset:[self.photos objectAtIndex:indexPath.row] original:NO callback:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (cell.indexPath.row == indexPath.row) {
            cell.photo = result;
        }
    }];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photos count];
}


#pragma mark - get/set
-(UICollectionViewFlowLayout *)layout{
    if (_layout == nil) {
        _layout = [UICollectionViewFlowLayout new];
        int nol = 4;
        float interSpacing = 5;
        float lineSpacing = 5;
        CGFloat width = floor( (ScreenWidth- (nol - 1) * interSpacing) / nol);
        _layout.itemSize = CGSizeMake(width, width);
        _layout.minimumInteritemSpacing = interSpacing;
        _layout.minimumLineSpacing = lineSpacing;
    }
    return _layout;
}

-(UICollectionView *)showPhotoCollectionView{
    if (_showPhotoCollectionView == nil) {
        
        _showPhotoCollectionView = [[UICollectionView
                                         alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
        _showPhotoCollectionView.backgroundColor = [UIColor whiteColor];
        [_showPhotoCollectionView registerClass:[PhotoCCell class] forCellWithReuseIdentifier:@"PhotoCCell"];
        
        [self.view addSubview:_showPhotoCollectionView];
        
        _showPhotoCollectionView.delegate = self;
        _showPhotoCollectionView.dataSource = self;
    }
    return _showPhotoCollectionView;
}
@end
