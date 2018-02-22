//
//  ViewController.m
//  GPUImageFilter
//
//  Created by 孙金帅 on 2017/2/24.
//  Copyright © 2017年 孙金帅. All rights reserved.
//

#import "ViewController.h"
#import "AlbumFiterViewCell.h"
#import "AlbumFiterModel.h"
#import "AlbumFilterManager.h"
#import "Constant.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *albumFiterImages;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

static NSString * const reuseIdentifier = @"AlbumFiterViewCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    [self initialization];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate、UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.albumFiterImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumFiterViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.fiter = self.albumFiterImages[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(75, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 12, 0, 12);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImage *albumFiterImage = [UIImage imageNamed:@"maomao"];
    
    self.imageView.image = [self renderEditAfterAlbumImage:albumFiterImage didSelectItemAtIndex:indexPath.row];
}

// 渲染图片
- (UIImage *)renderEditAfterAlbumImage:(UIImage *)albumImage didSelectItemAtIndex:(NSInteger)filterImageIndex {
    
    GPUImageColormatrixFilterType filterType = [[AlbumFilterManager shareManager] colormatrixFilterTypeByIndex:filterImageIndex];
    return [[AlbumFilterManager shareManager] imageByFilteringImage:albumImage filterType:filterType];
}

#pragma mark -
- (void)initialization {
    
    UIImage *thumbnailImage = [UIImage imageNamed:@"maomao"];
    for (int i = 0; i < 14; i++) {
        AlbumFiterModel *fiter = [[AlbumFiterModel alloc] init];
        GPUImageColormatrixFilterType filterType = [[AlbumFilterManager shareManager] colormatrixFilterTypeByIndex:i];
        fiter.thumbnailName = [[AlbumFilterManager shareManager] getFilterName:filterType];
        UIImage *tempThumbnailImage = [[AlbumFilterManager shareManager] imageByFilteringImage:thumbnailImage filterType:filterType];
        fiter.thumbnailImage = tempThumbnailImage;
        [self.albumFiterImages addObject:fiter];
    }
}

#pragma mark - Lazy Load

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor redColor];
        _imageView.image = [UIImage imageNamed:@"maomao"];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        CGFloat imageViewWidth = FXScreenWidth;
        _imageView.frame = CGRectMake(0, (FXScreenHeight - imageViewWidth) * 0.5, imageViewWidth, imageViewWidth);
        _imageView.clipsToBounds = YES;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.minimumInteritemSpacing = 12;
        flowLayout.minimumLineSpacing = 12;
        CGFloat collectionViewHeight = FXScreenHeight - CGRectGetMaxY(self.imageView.frame);
        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), FXScreenWidth, collectionViewHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[AlbumFiterViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSMutableArray *)albumFiterImages {
    if (!_albumFiterImages) {
        _albumFiterImages = [NSMutableArray array];
    }
    return _albumFiterImages;
}

@end
