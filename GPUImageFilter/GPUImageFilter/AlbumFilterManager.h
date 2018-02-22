//
//  AlbumFilterManager.h
//  GPUImageFilter
//
//  Created by sunjinshuai on 2018/2/22.
//  Copyright © 2018年 孙金帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface AlbumFilterManager : NSObject

+ (instancetype)shareManager;

- (GPUImageColormatrixFilterType)colormatrixFilterTypeByIndex:(NSInteger)index;
- (NSString *)getFilterName:(GPUImageColormatrixFilterType)filterType;
// 滤镜
- (UIImage *)imageByFilteringImage:(UIImage *)inImage
                        filterType:(GPUImageColormatrixFilterType)filterType;

- (UIImage *)imageWithImage:(UIImage *)inImage
                colorMatrix:(const float *)colorMatrix;

@end
