//
//  Measure.h
//  TigerEye
//
//  Created by Shengying Liu on 14-11-24.
//  Copyright (c) 2014年 Clemosn_CPSP682. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Measure : NSObject

-(double)GetDistance:(double )lat1 firstLon:(double )lng1 secondLat:(double )lat2 secondLon:(double )lng2;
-(float)GetAngle:(double )lat1 firstLon:(double )lng1 secondLat:(double )lat2 secondLon:(double )lng2 angle:(float)ang;
@end
