//
//  ZPScanQrViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/10.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPScanQrViewController.h"

@interface ZPScanQrViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *myScanQr;

@end

@implementation ZPScanQrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatMyScanQr];
}

- (void)creatMyScanQr{
    // 1.创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.还原滤镜初始化属性
    [filter setDefaults];
    // 3.将需要生成二维码的数据转换成二进制
    NSData *data = [@"我很帅"  dataUsingEncoding:NSUTF8StringEncoding];
    // 4.给二维码滤镜设置数据
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 5.获取滤镜生成的图片
    CIImage *ciImage =  [filter outputImage];
    UIImage *bgImage = [self createNonInterpolatedUIImageFormCIImage:ciImage withSize:200];
    
    UIImage *iconImage = [UIImage imageNamed:@"00"];
    UIImage *newImage = [self createNewImageWithBg:bgImage icon:iconImage];
    
    // 6.设置图片到控件上
    self.myScanQr.image = newImage;
}

///  生成一张新的图片
///
///  @param bgImage 图片的背景
///  @param icon    图片的图标
- (UIImage *)createNewImageWithBg:(UIImage *)bgImage icon:(UIImage *)icon{
    // 1.开启图片上下文
    UIGraphicsBeginImageContext(bgImage.size);
    
    // 2.绘制背景
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    // 3.绘制图标
    CGFloat iconW = 50;
    CGFloat iconH = 50;
    CGFloat iconX = (bgImage.size.width - iconW) * 0.5;
    CGFloat iconY = (bgImage.size.height - iconH) * 0.5;
    [icon drawInRect:CGRectMake(iconX, iconY, iconW, iconH)];
    
    // 4.取出绘制好的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 5.关闭上下文
    UIGraphicsEndImageContext();
    // 6.返回生成好得图片
    return newImage;
}
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
