//
//  AlbumFiterViewCell.m
//  GPUImageFilter
//
//  Created by 孙金帅 on 2017/2/24.
//  Copyright © 2017年 孙金帅. All rights reserved.
//

#import "AlbumFiterViewCell.h"
#import "AlbumFiterModel.h"
#import <Masonry.h>

//self弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface AlbumFiterViewCell ()

@property (nonatomic, strong) UIImageView *filterImage;
@property (nonatomic, strong) UILabel *filterLabel;

@end

@implementation AlbumFiterViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.exclusiveTouch = YES;
        [self setUp];
    }
    return self;
}

- (void)setFiter:(AlbumFiterModel *)fiter {
    
    _fiter = fiter;
    
    self.filterLabel.text = fiter.thumbnailName;
    self.filterImage.image = fiter.thumbnailImage;
}

- (void)setUp {
    WS(weakSelf);
    [self.filterImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(75, 75));
    }];
    
    [self.filterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.filterImage.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(25);
    }];
}

#pragma mark - Lazy Load
- (UIImageView *)filterImage {
    if (!_filterImage) {
        _filterImage = [[UIImageView alloc] init];
        _filterImage.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_filterImage];
    }
    return _filterImage;
}

- (UILabel *)filterLabel {
    if (!_filterLabel) {
        _filterLabel = [[UILabel alloc] init];
        _filterLabel.textColor = [UIColor lightGrayColor];
        _filterLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14.0];
        _filterLabel.textAlignment = NSTextAlignmentCenter;
        _filterLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_filterLabel];
    }
    return _filterLabel;
}

@end
