//
//  caneraController.h
//  RESideMenuStoryboardsExample
//
//  Created by Zian Chen on 11/10/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface cameraController : NSObject

@property AVCaptureVideoPreviewLayer * previewLayer;
@property AVCaptureSession * session;

-(void)addDevice;
- (void)setPortrait;
- (void)setLandscapeLeft;
- (void)setLandscapeRight;
- (void)addVideoPreviewLayer;

@end


