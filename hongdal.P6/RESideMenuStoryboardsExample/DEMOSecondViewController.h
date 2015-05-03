//
//  DEMOSecondViewController.h
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "cameraController.h"

@interface DEMOSecondViewController : UIViewController

@property (nonatomic, strong) cameraController *cameraController;
@property (nonatomic, strong) UIView * upperView;
@property (nonatomic, strong) UILabel * maxRadiusLabel;

- (IBAction)pushViewController:(id)sender;

@end
