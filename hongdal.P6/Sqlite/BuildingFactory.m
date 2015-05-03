//
//  BuildingFactory.m
//  RESideMenuStoryboardsExample
//
//  Created by shashibici on 12/3/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import "BuildingFactory.h"

@interface BuildingFactory()

@end

@implementation BuildingFactory

static sqlite3* dbinstance = NULL;
static sqlite3_stmt *statement = NULL;


+ (sqlite3*) dbinstance
{
    if (dbinstance == NULL)
    {
        NSString *path = [self dataFilePath];
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"building10" ofType:@"sqlite"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:path]) {
            NSError *error;
            if (![fileManager copyItemAtPath:dataPath toPath:path error:&error]) {
                NSLog(@"%@",[error localizedDescription]);
            }
        }
        
        if (sqlite3_open([path UTF8String], &dbinstance)!=SQLITE_OK) {
            sqlite3_close(dbinstance);
            dbinstance = NULL;
            NSLog(@"create database failed!");
        }
    }
    
    return dbinstance;
}

+(NSString *) dataFilePath{
    
    NSArray *path =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *document = [path objectAtIndex:0];
    
    return [document stringByAppendingPathComponent:@"building10.sqlite"];// name of the sqlite file.
}

+ (BOOL) excuteSql:(NSString*)sql{
    
    char *ERROR;
    if (sqlite3_exec(BuildingFactory.dbinstance, [sql UTF8String], NULL, NULL, &ERROR)!=SQLITE_OK){
        sqlite3_close(BuildingFactory.dbinstance);
        NSLog(@"Fail to execute sql");
        return false;
    }
    else
    {
        NSLog(@"excute sql successfully!");
        return true;
    }
}



// success: return building
// fail: return nil
+(Building*) getBuildingByName:(NSString *)name
{
    
    NSString *stmt = [NSString stringWithFormat:
                      @"select *    \
                      from Building \
                      where Building.bname = \'%@\';",name];
    
    Building* building = nil;
    if (sqlite3_prepare_v2(BuildingFactory.dbinstance,
                           [stmt UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            building = [[Building alloc] init];
            building.name = [[NSString alloc] initWithUTF8String:
                             (const char *) sqlite3_column_text(statement, 1)];
            
            building.lat = sqlite3_column_double(statement, 2);
            building.lon = sqlite3_column_double(statement, 3);
            building.image = [[NSString alloc] initWithUTF8String:
                              (const char *) sqlite3_column_text(statement, 4)];
        }
    }
    
    return building;
}



+(NSMutableArray*) getAllBuildings
{
    
    NSString *stmt = [NSString stringWithFormat:
                      @"select bname    \
                      from Building;"];
    NSMutableArray *buildings = nil;
    
    if (sqlite3_prepare_v2(BuildingFactory.dbinstance,
                           [stmt UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        buildings = [[NSMutableArray alloc] init];
        NSMutableArray *tmpNames = [[NSMutableArray alloc] init];
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            NSString *name = [[NSString alloc] initWithUTF8String:
                              (const char *) sqlite3_column_text(statement, 0)];
            [tmpNames addObject:name];
        }
        
        for (unsigned int i=0; i < tmpNames.count; ++i)
        {
            Building* tmpb = [BuildingFactory getBuildingByName:tmpNames[i]];
            if (tmpb != nil)
            {
                [buildings addObject:tmpb];
            }
        }
    }
    return buildings;
}





@end
