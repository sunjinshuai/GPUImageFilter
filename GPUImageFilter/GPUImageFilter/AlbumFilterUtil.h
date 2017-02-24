//
//  AlbumFilterUtil.h
//  GPUImageFilter
//
//  Created by 孙金帅 on 2017/2/24.
//  Copyright © 2017年 孙金帅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GPUImageColormatrixFilterType) {
    GPUImageColormatrixFilterTypeORI = 0,   // 原图
    GPUImageColormatrixFilterTypeFUGU,      // 鲜亮
    GPUImageColormatrixFilterTypeDANYA,     // 胶片
    GPUImageColormatrixFilterTypeHEIBAI,    // 黑白
    GPUImageColormatrixFilterTypeLANGMAN,   // 薄暮
    GPUImageColormatrixFilterTypeJIUHONG,   // 美食
    GPUImageColormatrixFilterTypeRUISE,     // 流年
    GPUImageColormatrixFilterTypeGETE,      // 暖暖
    GPUImageColormatrixFilterTypeLANDIAO,   // 白露
    GPUImageColormatrixFilterTypeQINGNING,  // 少女
    GPUImageColormatrixFilterTypeGUANGYUN,  // 时光
    GPUImageColormatrixFilterTypeMENGHUAN,  // 维也纳
    GPUImageColormatrixFilterTypeYESE,      // 夜色
    GPUImageColormatrixFilterTypeLOMO,      // 布拉格
};

@interface AlbumFilterUtil : NSObject

+ (AlbumFilterUtil *)sharedInstance;

- (GPUImageColormatrixFilterType)colormatrixFilterTypeByIndex:(NSInteger)index;
- (NSString *)getFilterName:(GPUImageColormatrixFilterType)filterType;
// 滤镜
- (UIImage *)imageByFilteringImage:(UIImage *)inImage filterType:(GPUImageColormatrixFilterType)filterType;
- (UIImage *)imageWithImage:(UIImage *)inImage withColorMatrix:(const float *)colorMatrix;

@end
