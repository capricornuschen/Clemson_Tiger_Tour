//
//  GlobalData.m
//  RESideMenuStoryboardsExample
//
//  Created by ChenYirui on 12/7/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import "GlobalData.h"

@implementation GlobalData

static double lat = 0;
static double lon = 0;

+(double) lat
{
    return lat;
}

+(void) setLat:(double)la
{
    lat = la;
}

+(double) lon
{
    return lon;
}

+(void) setLon:(double)lo
{
    lon = lo;
}
@end
