//
//  TourguideViewController.m
//  RESideMenuStoryboardsExample
//
//  Created by Zian Chen on 11/10/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import "TourguideViewController.h"
#import <GoogleMaps/GoogleMaps.h>

#import "GlobalData.h"

@interface TourguideViewController ()

@end

@implementation TourguideViewController
@synthesize lat,m_map,llong,compassArray,screen_width,screen_height,m_poi, m_poi2;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.buildingLocations = [BuildingFactory getAllBuildings];
    
    m_sqlite = [[CSqlite alloc]init];
    [m_sqlite openSqlite];
    
    // request current location by starting mapkit service and CLLocation service
    m_map.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
#endif
    [self.locationManager startUpdatingLocation];
    
    m_map.showsUserLocation = YES;
    [m_map setMapType:MKMapTypeStandard];
    [m_map setZoomEnabled:YES];
    [m_map setScrollEnabled:YES];
    
    //[self OpenGPS];

    screen_width = [UIScreen mainScreen].applicationFrame.size.width;
    screen_height = [UIScreen mainScreen].applicationFrame.size.height;
    
    //指南针的箭头
    compassArray = [[MyArray alloc] initWithFrame:CGRectMake(0, 0,60, 142)];
    [compassArray Init];
    compassArray.center = CGPointMake(screen_height/2, screen_width*4/5);
    compassArray.hidden = YES;
    
    [self.upperView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)];
    
    [self.upperView addSubview:compassArray];
    
    [self.view addSubview:self.upperView];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];

    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    NSLog(@"%@\n", [self deviceLocation]);
    
    //View Area
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 0.005f;
    region.span.longitudeDelta = 0.005f;
    [self.m_map setRegion:region animated:YES];
    
    [self.view addSubview:self.upperView];
    
}

-(void)viewDidDisappear:(BOOL)animated {
    //NSLog(@"run to disappear +++++++++++++++%@",m_poi);
    //[self.m_map removeAnnotation:m_poi];
}

- (void)appDidEnterForeground:(NSNotification *)notification {
    //NSLog(@"did enter foreground notification");
}

- (void)appDidEnterbackground:(NSNotification *)notification {
    //NSLog(@"did enter background notification");
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.m_map setRegion:[self.m_map regionThatFits:region] animated:YES];
}
- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"当前latitude: %0.6f,当前longitude: %0.6f\n", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceLat {
    return [NSString stringWithFormat:@"当前latitude: %0.6f\n", self.locationManager.location.coordinate.latitude];
}
- (NSString *)deviceLon {
    return [NSString stringWithFormat:@"当前longitude: %0.6f\n", self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceAlt {
    return [NSString stringWithFormat:@"当前altitude: %0.6f\n", self.locationManager.location.altitude];
}


- (void)viewDidUnload
{
    [self setLat:nil];
    [self setLlong:nil];
    [self setOffLat:nil];
    [self setOffLog:nil];
    [self setM_map:nil];
    [self setM_locationName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortrait);
}
//UIInterfaceOrientationLandscapeLeft

//UIInterfaceOrientationPortraitUpsideDown


- (void) OpenGPS {
    if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter=0.5;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation]; // 开始定位
    }
    else
    {
        [locationManager requestAlwaysAuthorization];
    }
    
    NSLog(@"GPS 启动");
}

// 定位成功时调用
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D mylocation = newLocation.coordinate;//手机GPS
    lat.text = [[NSString alloc]initWithFormat:@"%lf",mylocation.latitude];
    llong.text = [[NSString alloc]initWithFormat:@"%lf",mylocation.longitude];
    
    mylocation = [self zzTransGPS:mylocation];///火星GPS
    self.offLat.text = [[NSString alloc]initWithFormat:@"%lf",mylocation.latitude];
    self.offLog.text = [[NSString alloc]initWithFormat:@"%lf",mylocation.longitude];
    
    //显示火星坐标
    [self SetMapPoint:mylocation];
    
    //获取位置信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray* placemarks,NSError *error)
     {
         if (placemarks.count >0   )
         {
             CLPlacemark * plmark = [placemarks objectAtIndex:0];
             
             NSString * country = plmark.country;
             NSString * city    = plmark.locality;
             
             
             //NSLog(@"%@-%@-%@",country,city,plmark.name);
             self.m_locationName.text =plmark.name;
         }
         
         //NSLog(@"%@",placemarks);
         
     }];
    
    //[geocoder release];
    
}
// 定位失败时调用
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
}

-(CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps
{
    int TenLat=0;
    int TenLog=0;
    TenLat = (int)(yGps.latitude*10);
    TenLog = (int)(yGps.longitude*10);
    NSString *sql = [[NSString alloc]initWithFormat:@"select offLat,offLog from gpsT where lat=%d and log = %d",TenLat,TenLog];
    //NSLog(@"%@",sql);
    sqlite3_stmt* stmtL = [m_sqlite NSRunSql:sql];
    int offLat=0;
    int offLog=0;
    while (sqlite3_step(stmtL)==SQLITE_ROW)
    {
        offLat = sqlite3_column_int(stmtL, 0);
        offLog = sqlite3_column_int(stmtL, 1);
        
    }
    
    yGps.latitude = yGps.latitude+offLat*0.0001;
    yGps.longitude = yGps.longitude + offLog*0.0001;
    return yGps;
    
    
}

-(void)SetMapPoint:(CLLocationCoordinate2D)myLocation
{
    if (self.m_poi != nil)
    {
        [self.m_map removeAnnotation:m_poi];
    }
    m_poi = [[POI alloc]initWithCoords:myLocation];
    [self.m_map addAnnotation:m_poi];

    
    
    CLLocationCoordinate2D myLocation2;
    myLocation2.latitude = GlobalData.lat;
    myLocation2.longitude = GlobalData.lon;
    if (self.m_poi2 != nil)
    {
        [self.m_map removeAnnotation:m_poi];
    }
    self.m_poi2 = [[POI alloc]initWithCoords:myLocation2];
    [self.m_map addAnnotation:m_poi2];

    MKCoordinateRegion theRegion = { {0.0, 0.0 }, { 0.0, 0.0 } };
    theRegion.center=myLocation;
    [self.m_map setZoomEnabled:YES];
    [self.m_map setScrollEnabled:YES];
    theRegion.span.longitudeDelta = 0.01f;
    theRegion.span.latitudeDelta = 0.01f;
    [self.m_map setRegion:theRegion animated:YES];
}
@end


@implementation POI

@synthesize coordinate,subtitle,title;

- (id) initWithCoords:(CLLocationCoordinate2D) coords{
    
    self = [super init];
    
    if (self != nil) {
        
        coordinate = coords;
        
    }
    
    return self;
    
}

@end








