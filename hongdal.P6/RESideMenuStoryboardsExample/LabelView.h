//
//  LabelController.h
//  RESideMenuStoryboardsExample
//
//  Created by Zian Chen on 11/24/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelView : UIView

@property (nonatomic, strong) UILabel * maxRadiusLabel;
@property (nonatomic, strong) UIButton * button;


-(UILabel*)setLabel;
-(UIButton*)setButton;

@end
