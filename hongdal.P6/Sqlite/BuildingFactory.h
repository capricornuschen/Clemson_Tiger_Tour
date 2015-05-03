//
//  BuildingFactory.h
//  RESideMenuStoryboardsExample
//
//  Created by shashibici on 12/3/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "Building.h"

/***
 Obtain a building record from external database.
    select building_id,building_name,latitude,longitude,bimage_path from BImage,Building where BImage.bimage_id = Building.building_id and building_name = 'Macadams'
 
 
 ***/

@interface BuildingFactory : NSObject

+(NSString *) dataFilePath;
+(sqlite3*) dbinstance;
+ (BOOL) excuteSql:(NSString*)sql;

+ (Building*) getBuildingByName:(NSString*)name;
+ (NSMutableArray*) getAllBuildings;

@end
