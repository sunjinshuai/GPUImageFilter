//
//  Constant.h
//  GPUImageFilter
//
//  Created by sunjinshuai on 2018/2/22.
//  Copyright © 2018年 孙金帅. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

//self弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

typedef NS_ENUM(NSInteger, GPUImageColormatrixFilterType) {
    GPUImageColormatrixFilterTypeORI = 0,   // 原图
    GPUImageColormatrixFilterTypePrague,    // 布拉格
    GPUImageColormatrixFilterTypeHEIBAI,    // 黑白
    GPUImageColormatrixFilterTypeBright,    // 鲜亮
    GPUImageColormatrixFilterTypeWarm,      // 暖暖
    GPUImageColormatrixFilterTypeFleeting,  // 流年
    GPUImageColormatrixFilterTypeFilm,      // 胶片
    GPUImageColormatrixFilterTypeDelicacy,  // 美食
    GPUImageColormatrixFilterTypeGirl,      // 少女
    GPUImageColormatrixFilterTypeDusk,      // 薄暮
    GPUImageColormatrixFilterTypeTimes,     // 时光
    GPUImageColormatrixFilterTypeWhiteDew,  // 白露
    GPUImageColormatrixFilterTypeVienna,    // 维也纳
    GPUImageColormatrixFilterTypeYESE,      // 夜色
};


// 屏幕尺寸
#define FXScreenBounds [UIScreen mainScreen].bounds
#define FXScreenSize [UIScreen mainScreen].bounds.size
#define FXScreenWidth [UIScreen mainScreen].bounds.size.width
#define FXScreenHeight [UIScreen mainScreen].bounds.size.height

#endif /* Constant_h */
