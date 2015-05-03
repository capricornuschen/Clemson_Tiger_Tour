//
//  MyArray.m
//  TigerEye
//
//  Created by Shengying Liu on 14-12-2.
//  Copyright (c) 2014年 Clemosn_CPSP682. All rights reserved.
//

#import "MyArray.h"

@implementation MyArray
@synthesize arrayImg,rotationAnimation,angle,scale;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//初始化
-(void)Init{
    
    arrayImg = [[UIImageView alloc]
                      initWithFrame:CGRectMake(0,0, 60, 142)];
    [arrayImg setImage:[UIImage imageNamed:@"arrawfix.png"]];
    [arrayImg setContentMode:UIViewContentModeScaleAspectFit];
//    arrayImg.center = CGPointMake(screenwidth/2, screenheight/2);
    arrayImg.hidden = NO;
    [self addSubview:arrayImg];

}
//设置箭头图片的转角
-(void)setAngle:(float)Angle{
    angle = Angle*M_PI*2.0/360;
    arrayImg.transform = CGAffineTransformMakeRotation(angle);
//    arrayImg.transform = CGAffineTransformMakeScale(1,scale);
}
-(float)getAngle{
    return angle;
}

@end
