//
//  ZPScanViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/9.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZPScanQrViewController.h"

@interface ZPScanViewController () <AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
- (IBAction)closeScanView:(id)sender;
- (IBAction)photoAlbum:(id)sender;
@property (nonatomic, strong) AVCaptureSession *session;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hightConstraint;
//定时器
@property (nonatomic, strong) CADisplayLink *timeLink;

@end
@implementation ZPScanViewController

- (IBAction)photoAlbum:(id)sender {
    
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
//    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
//    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
//        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面

}
- (IBAction)closeScanView:(id)sender {
    [self.timeLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //MARK: 模拟器不能使用二维码扫描功能
//    [self addScanDevice];
}
//MARK:获取扫描设备实现扫描功能
- (void)addScanDevice
{   //1,实例化拍摄设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2,设置输入设备
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
    //3,实例化拍摄数据输出
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    //4,设置输出数据代理
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //5,实例化拍摄会话
    _session = [[AVCaptureSession alloc]init];
    [_session addInput:input];
    [_session addOutput:output];
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    //6,实例化预览图层
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.bounds;
    //7,将图层插入当前视图
    [self.view.layer insertSublayer:layer atIndex:0];
    
}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSLog(@"%s",__func__);
}
//MARK:设置冲击波
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.timeLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.timeLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//}
- (void)runWave
{
    self.hightConstraint.constant -= 2;
    if (self.hightConstraint.constant <= -200) {
        self.hightConstraint.constant = 200;
    }
}
- (CADisplayLink *)timeLink
{
    if (_timeLink == nil) {
        _timeLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(runWave)];
    }
    return _timeLink;
}



@end
