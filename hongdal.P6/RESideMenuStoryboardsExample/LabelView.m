//
//  LabelController.m
//  RESideMenuStoryboardsExample
//
//  Created by Zian Chen on 11/24/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import "LabelView.h"

@implementation LabelView

-(UILabel*)setLabel
{
    
    self.maxRadiusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 125, 80, 60)];
    self.maxRadiusLabel.backgroundColor = [UIColor clearColor];//[UIColor blueColor];
    self.maxRadiusLabel.textColor = [UIColor whiteColor];
    self.maxRadiusLabel.font = [UIFont systemFontOfSize:15.0];
    self.maxRadiusLabel.textAlignment = NSTextAlignmentCenter;
    self.maxRadiusLabel.text = @"80 km";
    self.maxRadiusLabel.hidden = NO;
    return self.maxRadiusLabel;
}


- (UIButton*) setButton
{
    
    
    //self.button.textColor = [UIColor orangeColor];
    //self.button.font = [UIFont systemFontOfSize:15.0];
    //self.button.textAlignment = NSTextAlignmentCenter;
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //self.button.backgroundColor = [UIColor blueColor];
    [self.button setTitle:@"Click Me" forState:UIControlStateNormal];
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"label2.png"]];
    self.button.backgroundColor = color;
    //[self.button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
    [self.button setFrame:CGRectMake(100, 40, 100, 30)];
    return self.button;
    
}


@end
