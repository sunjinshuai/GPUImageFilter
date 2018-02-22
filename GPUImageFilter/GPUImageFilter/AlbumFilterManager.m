//
//  AlbumFilterManager.m
//  GPUImageFilter
//
//  Created by sunjinshuai on 2018/2/22.
//  Copyright © 2018年 孙金帅. All rights reserved.
//

#import "AlbumFilterManager.h"
#import "ColorConstant.h"
#import "InstaFilters.h"
#import <GPUImage.h>

@implementation AlbumFilterManager

+ (instancetype)shareManager {
    static AlbumFilterManager *_shareManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[AlbumFilterManager alloc] init];
    });
    return _shareManager;
}

- (GPUImageColormatrixFilterType)colormatrixFilterTypeByIndex:(NSInteger)index {
    
    GPUImageColormatrixFilterType filterType = GPUImageColormatrixFilterTypeORI;
    switch (index) {
        case 0:
            filterType = GPUImageColormatrixFilterTypeORI;
            break;
        case 1:
            filterType = GPUImageColormatrixFilterTypePrague;
            break;
        case 2:
            filterType = GPUImageColormatrixFilterTypeHEIBAI;
            break;
        case 3:
            filterType = GPUImageColormatrixFilterTypeBright;
            break;
        case 4:
            filterType = GPUImageColormatrixFilterTypeWarm;
            break;
        case 5:
            filterType = GPUImageColormatrixFilterTypeFleeting;
            break;
        case 6:
            filterType = GPUImageColormatrixFilterTypeFilm;
            break;
        case 7:
            filterType = GPUImageColormatrixFilterTypeDelicacy;
            break;
        case 8:
            filterType = GPUImageColormatrixFilterTypeGirl;
            break;
        case 9:
            filterType = GPUImageColormatrixFilterTypeDusk;
            break;
        case 10:
            filterType = GPUImageColormatrixFilterTypeTimes;
            break;
        case 11:
            filterType = GPUImageColormatrixFilterTypeWhiteDew;
            break;
        case 12:
            filterType = GPUImageColormatrixFilterTypeVienna;
            break;
        case 13:
            filterType = GPUImageColormatrixFilterTypeYESE;
            break;
        default:
            break;
    }
    return filterType;
}

- (NSString *)getFilterName:(GPUImageColormatrixFilterType)filterType {
    
    NSString *title = @"";
    switch (filterType) {
        case GPUImageColormatrixFilterTypeORI:
            title = @"原图";
            break;
        case GPUImageColormatrixFilterTypePrague:
            title = @"布拉格";
            break;
        case GPUImageColormatrixFilterTypeDelicacy:
            title = @"美食";
            break;
        case GPUImageColormatrixFilterTypeBright:
            title = @"鲜亮";
            break;
        case GPUImageColormatrixFilterTypeWarm:
            title = @"暖暖";
            break;
        case GPUImageColormatrixFilterTypeFleeting:
            title = @"流年";
            break;
        case GPUImageColormatrixFilterTypeFilm:
            title = @"胶片";
            break;
        case GPUImageColormatrixFilterTypeHEIBAI:
            title = @"黑白";
            break;
        case GPUImageColormatrixFilterTypeGirl:
            title = @"少女";
            break;
        case GPUImageColormatrixFilterTypeDusk:
            title = @"薄暮";
            break;
        case GPUImageColormatrixFilterTypeTimes:
            title = @"时光";
            break;
        case GPUImageColormatrixFilterTypeWhiteDew:
            title = @"白露";
            break;
        case GPUImageColormatrixFilterTypeVienna:
            title = @"维也纳";
            break;
        case GPUImageColormatrixFilterTypeYESE:
            title = @"夜色";
            break;
        default:
            break;
    }
    return title;
}

- (UIImage *)imageByFilteringImage:(UIImage *)inImage
                        filterType:(GPUImageColormatrixFilterType)filterType {
    
    IFImageFilter *filter = [[IFImageFilter alloc] init];
    
    switch (filterType) {
        case 0:
            return inImage;
            break;
        case 1: {
            filter = [[IF1977Filter alloc] init];
        }
            break;
        case 2: {
            filter = [[IFInkwellFilter alloc] init];
        }
            break;
        case 3: {
            filter = [[IFBrannanFilter alloc] init];
        }
            break;
        case 4: {
            filter = [[IFEarlybirdFilter alloc] init];
        }
            break;
        case 5: {
            filter = [[IFHefeFilter alloc] init];
        }
            break;
        case 6: {
            filter = [[IFHudsonFilter alloc] init];
        }
            break;
        case 7: {
            filter = [[IFAmaroFilter alloc] init];
        }
            break;
        case 8: {
            filter = [[IFLomofiFilter alloc] init];
        }
            break;
        case 9: {
            filter = [[IFLordKelvinFilter alloc] init];
        }
            break;
        case 10: {
            filter = [[IFNashvilleFilter alloc] init];
        }
            break;
        case 11: {
            filter = [[IFNormalFilter alloc] init];
        }
            break;
        case 12: {
            filter = [[IFRiseFilter alloc] init];
        }
            break;
        case 13: {
            filter = [[IFSierraFilter alloc] init];
        }
            break;
        default:
            break;
    }
    return [filter imageByFilteringImage:inImage];
    
}

- (UIImage *)imageWithImage:(UIImage *)inImage
                colorMatrix:(const float *)colorMatrix {
    
    unsigned char *imgPixel = RequestImagePixelData(inImage);
    CGImageRef inImageRef = [inImage CGImage];
    GLuint w = CGImageGetWidth(inImageRef);
    GLuint h = CGImageGetHeight(inImageRef);
    
    int wOff = 0;
    int pixOff = 0;
    
    // 双层循环按照长宽的像素个数迭代每个像素点
    for (GLuint y = 0; y< h; y++) {
        
        pixOff = wOff;
        for (GLuint x = 0; x<w; x++) {
            int red = (unsigned char)imgPixel[pixOff];
            int green = (unsigned char)imgPixel[pixOff+1];
            int blue = (unsigned char)imgPixel[pixOff+2];
            int alpha = (unsigned char)imgPixel[pixOff+3];
            changeRGBA(&red, &green, &blue, &alpha, colorMatrix);
            
            // 回写数据
            imgPixel[pixOff] = red;
            imgPixel[pixOff+1] = green;
            imgPixel[pixOff+2] = blue;
            imgPixel[pixOff+3] = alpha;
            pixOff += 4; //将数组的索引指向下四个元素
        }
        wOff += w * 4;
    }
    
    NSInteger dataLength = w * h * 4;
    
    // 下面的代码创建要输出的图像的相关参数
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, imgPixel, dataLength, NULL);
    
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4 * w;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    // 创建要输出的图像
    CGImageRef imageRef = CGImageCreate(w, h, bitsPerComponent, bitsPerPixel, bytesPerRow,colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
    
    UIImage *myImage = [UIImage imageWithCGImage:imageRef];
    
    CFRelease(imageRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(provider);
    return myImage;
}

#pragma mark - 滤镜
// 返回一个使用RGBA通道的位图上下文
static CGContextRef CreateRGBABitmapContext (CGImageRef inImage) {
    
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    void *bitmapData; //内存空间的指针，该内存空间的大小等于图像使用RGB通道所占用的字节数。
    NSInteger bitmapByteCount;
    NSInteger bitmapBytesPerRow;
    size_t pixelsWide = CGImageGetWidth(inImage); //获取横向的像素点的个数
    size_t pixelsHigh = CGImageGetHeight(inImage); //纵向
    bitmapBytesPerRow = (pixelsWide * 4); //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit(0-255)的空间
    bitmapByteCount    = (bitmapBytesPerRow * pixelsHigh); //计算整张图占用的字节数
    colorSpace = CGColorSpaceCreateDeviceRGB();//创建依赖于设备的RGB通道
    bitmapData = malloc(bitmapByteCount); //分配足够容纳图片字节数的内存空间
    context = CGBitmapContextCreate (bitmapData, pixelsWide, pixelsHigh, 8, bitmapBytesPerRow, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    // 创建CoreGraphic的图形上下文，该上下文描述了bitmaData指向的内存空间需要绘制的图像的一些绘制参数
    CGColorSpaceRelease(colorSpace);
    //Core Foundation中通过含有Create、Alloc的方法名字创建的指针，需要使用CFRelease()函数释放
    return context;
}

// 返回一个指针，该指针指向一个数组，数组中的每四个元素都是图像上的一个像素点的RGBA的数值(0-255)，用无符号的char是因为它正好的取值范围就是0-255
static unsigned char *RequestImagePixelData(UIImage *inImage) {
    
    CGImageRef img = [inImage CGImage];
    CGSize size = [inImage size];
    CGContextRef cgctx = CreateRGBABitmapContext(img); //使用上面的函数创建上下文
    CGRect rect = {{0,0},{size.width, size.height}};
    CGContextDrawImage(cgctx, rect, img); //将目标图像绘制到指定的上下文，实际为上下文内的bitmapData。
    unsigned char *data = CGBitmapContextGetData (cgctx);
    CGContextRelease(cgctx);//释放上面的函数创建的上下文
    return data;
}

// 修改RGB的值
static void changeRGBA(int *red,int *green,int *blue,int *alpha, const float* f) {
    
    int redV = *red;
    int greenV = *green;
    int blueV = *blue;
    int alphaV = *alpha;
    *red = f[0] * redV + f[1] * greenV + f[2] * blueV + f[3] * alphaV + f[4];
    *green = f[0+5] * redV + f[1+5] * greenV + f[2+5] * blueV + f[3+5] * alphaV + f[4+5];
    *blue = f[0+5*2] * redV + f[1+5*2] * greenV + f[2+5*2] * blueV + f[3+5*2] * alphaV + f[4+5*2];
    *alpha = f[0+5*3] * redV + f[1+5*3] * greenV + f[2+5*3] * blueV + f[3+5*3] * alphaV + f[4+5*3];
    
    if (*red > 255) {
        *red = 255;
    }
    if(*red < 0) {
        *red = 0;
    }
    if (*green > 255) {
        *green = 255;
    }
    if (*green < 0) {
        *green = 0;
    }
    if (*blue > 255) {
        *blue = 255;
    }
    if (*blue < 0) {
        *blue = 0;
    }
    if (*alpha > 255) {
        *alpha = 255;
    }
    if (*alpha < 0) {
        *alpha = 0;
    }
}

@end
