//
//  Measure.m
//  TigerEye
//
//  Created by Shengying Liu on 14-11-24.
//  Copyright (c) 2014年 Clemosn_CPSP682. All rights reserved.
//

#import "Measure.h"

const double EARTH_RADIUS = 6378.137;

@implementation Measure

-(double)rad:(double )d
{
    return d * M_PI / 180.0;
}

-(double)GetDistance:(double )lat1 firstLon:(double )lng1
           secondLat:(double )lat2 secondLon:(double )lng2{
    
    double radLat1 = [self rad:lat1];
    double radLat2 = [self rad:lat2 ];
    double a = radLat1 - radLat2;
    double b = [self rad:lng1] - [self rad:lng2];
    
    double s = 2 * asin(sqrt(pow(sin(a/2),2) +
                             cos(radLat1)*cos(radLat2)*pow(sin(b/2),2)));
    s = s * EARTH_RADIUS;
    s = round(s * 10000) / 10000;
    return s;
}

-(float)GetAngle:(double )lat1 firstLon:(double )lng1 secondLat:(double )lat2 secondLon:(double )lng2 angle:(float)ang{
    
    ang = ang-270;
    if((ang > -270)&&(ang < -180)){ang = 360 + ang ;}
//    ang = ang-290;
 //   if((ang > -290)&&(ang < -180)){ang = 360 + ang ;}
    float angle = 0.0;
    if((lat1 > lat2)&&(lng1 > lng2)){
        angle = atan( sin((lat1 - lat2)*M_PI/180)/sin((lng1 - lng2)*M_PI/180) )*180/M_PI+90-ang;
    }
    if((lat1 < lat2)&&(lng1 > lng2)){
        angle = 90 - atan( sin((lat2 - lat1)*M_PI/180)/sin((lng1 - lng2)*M_PI/180) )*180/M_PI-ang;
    }
    if((lat1 > lat2)&&(lng1 < lng2)){
        angle = -atan( sin((lat1 - lat2)*M_PI/180)/sin((lng2 - lng1))*M_PI/180 )*180/M_PI-90-ang;
    }
    if((lat1 < lat2)&&(lng1 < lng2)){
        angle = atan( sin((lat2 - lat1)*M_PI/180)/sin((lng2 - lng1))*M_PI/180 )*180/M_PI-90-ang;
    }

    return angle;
}
@end
