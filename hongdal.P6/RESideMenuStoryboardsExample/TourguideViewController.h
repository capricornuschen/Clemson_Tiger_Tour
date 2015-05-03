//
//  TourguideViewController.h
//  RESideMenuStoryboardsExample
//
//  Created by Zian Chen on 11/10/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CSqlite.h"
#import "MyArray.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>

#import "BuildingFactory.h"

//#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface POI : NSObject <MKAnnotation> {
    
    CLLocationCoordinate2D coordinate;
    NSString *subtitle;
    NSString *title;
}

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *subtitle;
@property (nonatomic,retain) NSString *title;



-(id) initWithCoords:(CLLocationCoordinate2D) coords;

@end

@interface TourguideViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    CSqlite *m_sqlite;
}


@property (weak, nonatomic) IBOutlet UILabel *lat;
@property (weak, nonatomic) IBOutlet UILabel *llong;
@property (weak, nonatomic) IBOutlet UILabel *offLat;
@property (weak, nonatomic) IBOutlet UILabel *offLog;
@property(nonatomic, retain) IBOutlet MKMapView *m_map;
@property (nonatomic, strong) UIView * upperView;
@property(nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *m_locationName;
@property (nonatomic,retain) POI* m_poi;
@property (nonatomic,retain) POI* m_poi2;
@property(nonatomic)float screen_width;
@property(nonatomic)float screen_height;
@property (strong,nonatomic)MyArray * compassArray;
@property (nonatomic, strong) NSMutableArray *buildingLocations;

@end


