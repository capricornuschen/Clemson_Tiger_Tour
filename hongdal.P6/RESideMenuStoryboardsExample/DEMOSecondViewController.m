//
//  DEMOSecondViewController.m
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOSecondViewController.h"

@interface DEMOSecondViewController ()

@end

@implementation DEMOSecondViewController

- (IBAction)pushViewController:(id)sender
{
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = @"Pushed Controller";
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
    [self loadSetting];
    [self initInterface];
}

- (void)loadSetting
{
    [self loadView];
    self.cameraController=[[cameraController alloc]init];
    [self.cameraController addDevice];
    [self.cameraController addVideoPreviewLayer];
    [self.cameraController setPortrait];
    [[self.view layer] addSublayer:[self.cameraController previewLayer]];
    [self.cameraController.session startRunning];
    
}

-(void)initInterface
{
    //NSLog(@"init interface");
    self.maxRadiusLabel = [[UILabel alloc] initWithFrame:CGRectMake(158, 25, 30, 12)];
    self.maxRadiusLabel.backgroundColor = [UIColor blueColor];
    self.maxRadiusLabel.textColor = [UIColor whiteColor];
    self.maxRadiusLabel.font = [UIFont systemFontOfSize:10.0];
    self.maxRadiusLabel.textAlignment = NSTextAlignmentCenter;
    self.maxRadiusLabel.text = @"80 km";
    self.maxRadiusLabel.hidden = NO;
    [self.upperView addSubview:self.maxRadiusLabel];
    [self.view addSubview:self.upperView];
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) {
        self.upperView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)];
    } else {
        self.upperView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }
    self.view.userInteractionEnabled = YES;
    self.upperView.userInteractionEnabled = YES;
}

@end



