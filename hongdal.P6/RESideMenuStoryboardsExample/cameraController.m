//
//  caneraController.m
//  RESideMenuStoryboardsExample
//
//  Created by Zian Chen on 11/10/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import "cameraController.h"

@implementation cameraController

-(id)init{
    if((self=[super init]))
    {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
        [self createSession];
    }
    return self;
}

-(void)createSession
{
    self.session=[[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetMedium];
    
}
/**
 * @brief choose the media device and set it.choose video input here
 *
 */
-(void)addDevice
{
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if(videoDevice)
    {
        NSError * error;
        AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
        if(!error)
        {
            if([self.session canAddInput:videoInput])
                [self.session addInput:videoInput];
            else NSLog(@"here is cameraController.m addDevice input");
        }
        else
        {
            NSLog(@"here is cameraController.m addDevice");
            [error localizedDescription];
            
        }
    }
}



- (void)addVideoPreviewLayer {
    [self setPreviewLayer:[[AVCaptureVideoPreviewLayer alloc] initWithSession:[self session]]];
    [[self previewLayer] setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [[self.previewLayer connection] setVideoOrientation:AVCaptureVideoOrientationPortrait];
}



- (void)setPortrait {
    [[self.previewLayer connection] setVideoOrientation:AVCaptureVideoOrientationPortrait];
    CGRect layerRect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self screenLayer:layerRect];
}

- (void)setLandscapeLeft {
    [[self.previewLayer connection] setVideoOrientation:AVCaptureVideoOrientationLandscapeLeft];
    CGRect layerRect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    [self screenLayer:layerRect];
}

- (void)setLandscapeRight {
    [[self.previewLayer connection] setVideoOrientation:AVCaptureVideoOrientationLandscapeRight];
    CGRect layerRect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    [self screenLayer:layerRect];
}

- (void)screenLayer:(CGRect)layerRect {
    [[self previewLayer] setBounds:layerRect];
    [[self previewLayer] setVideoGravity: AVLayerVideoGravityResizeAspectFill];
    [[self previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect), CGRectGetMidY(layerRect))];
}

@end
