//
//  MyArray.h
//  TigerEye
//
//  Created by Shengying Liu on 14-12-2.
//  Copyright (c) 2014年 Clemosn_CPSP682. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyArray : UIView
@property(strong,nonatomic)UIImageView * arrayImg;
@property(nonatomic)float angle;
@property(strong,nonatomic)CABasicAnimation* rotationAnimation;
-(void)Init;
-(void)setAngle:(float)angle;
-(float)getAngle;
-(void)set3D:(float)det;
@property (nonatomic)float scale;

@end
