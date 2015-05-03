//
//  HuntingViewController.m
//  RESideMenuStoryboardsExample
//
//  Created by Zian Chen on 11/10/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import "HuntingViewController.h"
#import <CoreLocation/CLHeading.h>
#import "BuildingFactory.h"
#import "TourguideViewController.h"
#import "math.h"
//#import <GoogleMaps/GoogleMaps.h>

#import "GlobalData.h"

#define toRad(X) (X*M_PI/180.0)
#define toDeg(X) (X*180.0/M_PI)


@interface HuntingViewController ()

@end


@implementation HuntingViewController

@synthesize mapView,currentHeading,measure,mylat,mylon;
@synthesize labelArray,buttonArray;
@synthesize buildingArray, nameArray,latArray,lonArray;


- (id)init
{
    if (!(self = [super init])) return nil;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSetting];
    measure = [[Measure alloc] init];
    [self initInterface];

    //request current location by starting mapkit service and CLLocation service
    mapView.delegate = self;
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
    
    mapView.showsUserLocation = YES;
    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    

    currentHeading = 0.0;
    self.screenwidth = [UIScreen mainScreen].applicationFrame.size.width;
    self.screenheight = [UIScreen mainScreen].applicationFrame.size.height;

/**
    db = [DB sharedInstanceMethod];
    nameArray = [db getName];
    latArray =[db getLongitude];
    lonArray = [db getLatitude];
**/    

}

- (BOOL) shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.upperView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)];

    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    NSLog(@"%@", [self deviceLocation]);
    
    //View Area
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 0.005f;
    region.span.longitudeDelta = 0.005f;
    [mapView setRegion:region animated:YES];
    
    // update the heading events
    [self startLocationHeadingEvents];
    // display the latest heading information.
    [self updateHeadingDisplays];
    
}

- (void)startLocationHeadingEvents
{ 
    // Start heading updates.
    if ([CLLocationManager headingAvailable]) {
        // set heading filter to 3. move more than 3 in angle will trigger heading update.
        self.locationManager.headingFilter = 2.5;
        // start updating heading.
        [self.locationManager startUpdatingHeading];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector
        (updateDeviceMotion) userInfo:nil repeats:YES];
    
    self.motionManager = [[CMMotionManager alloc] init];
    
    self.motionManager.deviceMotionUpdateInterval = 1.0/10;
    
    [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical];
}

- (void)mapView:(MKMapView *)mkmapView didUpdateUserLocation:(MKUserLocation *)mkuserLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mkuserLocation.coordinate, 800, 800);
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
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


-(void)initInterface
{
    self.buttonArray=[[NSMutableArray alloc] init];
    self.labelArray = [[NSMutableArray alloc] init];
    self.nameArray = [[NSMutableArray alloc] init];
    self.latArray = [[NSMutableArray alloc] init];
    self.lonArray = [[NSMutableArray alloc] init];
    self.imageNameArray = [[NSMutableArray alloc] init];
    LabelView *tmpView = [[LabelView alloc] init];
    
    NSLog (@" init_interface-001");
    
    buildingArray = [BuildingFactory getAllBuildings];
    
    //Building *b = [BuildingFactory getBuildingByName:@"Sikes"];
    //NSLog (@"lat=%lf, lon=%lf", b.lat, b.lon);
    for (unsigned int i = 0; i < buildingArray.count; ++i)
    {
        Building *b = [buildingArray objectAtIndex:i];
        [self.nameArray addObject:b.name];
        [self.latArray addObject:[NSNumber numberWithDouble:b.lat]];
        [self.lonArray addObject:[NSNumber numberWithDouble:b.lon]];
        [self.imageNameArray addObject:b.image];
    }
    
    NSLog (@" init_interface-002");
    
    // add buttons and labels
    for(int i=0;i<self.nameArray.count;i++)
    {
        //[self.labelArray addObject:[[LabelView alloc] init]];
        //[[labelArray objectAtIndex:i] setLabel];
        [self.labelArray addObject:([tmpView setLabel])];
        [self.buttonArray addObject:([tmpView setButton])];
        UIButton *tmpb = [self.buttonArray objectAtIndex:i];
        tmpb.tag = i;
        [[self.buttonArray objectAtIndex:(i)] addTarget:self
                                                 action:@selector(touchLabel:)
                                       forControlEvents:UIControlEventTouchDown];
        [self.upperView addSubview:[self.buttonArray objectAtIndex:i]];
        [self.upperView addSubview:[self.labelArray objectAtIndex:i]];
        
        NSLog (@"button size = %lu", (unsigned long)self.buttonArray.count);
        //[array addObject:[NSString stringWithFormat:@"%@",[nameArray objectAtIndex:i]]];
    }
    
    [self.view addSubview:self.upperView];

    
    NSLog (@" init_interface-003");
    

}


// This method will be called back when the new heading information is available.
- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading
{
    // if headingAccuracy is not correctly set, the return.
    if (newHeading.headingAccuracy < 0)
        return;
    
    // Use the true heading if it is valid.
    CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?
                                       newHeading.trueHeading : newHeading.magneticHeading);
    
    self.currentHeading = theHeading;
    [self updateHeadingDisplays];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    //CLLocation *location = [locations lastObject];
    mylat = self.locationManager.location.coordinate.latitude;
    mylon = self.locationManager.location.coordinate.longitude;

    [self updateHeadingDisplays];
}

- (void) updateHeadingDisplays
{


    double heading = currentHeading;
    currentScreen = [UIScreen mainScreen];
    double screenwidth = currentScreen.applicationFrame.size.width;
    double screenheight = currentScreen.applicationFrame.size.height;
    //NSLog(@"lat=%lf, lon=%lf", mylat, mylon);
    //NSLog(@"heading %0.6f\n",heading);
    for (int i=0;i<nameArray.count;i++){
        double deslat = [[latArray objectAtIndex:i] doubleValue];
        double deslon = [[lonArray objectAtIndex:i] doubleValue];
        
    //NSLog(@"screenwidth=%lf, screenheight=%lf", screenwidth,screenheight);
    // the angle between label and center of the camera screen, caculate correspoding location of label should use method below,
    // label_possition/half_screen_wdith = labelangle/half_camera_opening_angle
    //NSLog(@"lat %0.6f, lon %0.6f\n",lat,lon);
    //NSLog(@"deslat %0.6f, deslon %0.6f\n",deslat,deslon);
    //NSLog(@"heading %0.6f\n",heading);
        
        float labelangle = [self.measure GetAngle:mylat firstLon:-mylon secondLat:deslat secondLon:-deslon angle:heading];
        
        float lablelDistance = [self.measure GetDistance:mylat firstLon:-mylon secondLat:deslat secondLon:-deslon];
        float yOffset = (lablelDistance - 0.30) * 50;
        
    //NSLog (@"labelangle[%d]=%lf",i,labelangle);
    //NSLog(@"lat=%lf, lon=%lf", currentLocation.latitude, currentLocation.longitude);
    //NSLog(@"deslat=%lf, deslon=%lf", deslat, deslon);
        //LabelView * temp = [labelArray objectAtIndex:i];
    //half_camera_opening_angle is 30 and half_screen_wdith is 240 (screen pixel is 480*320)
        float label_center_x = (labelangle/30) * (screenwidth/2)+screenwidth/2;
    //NSLog (@"labelposition=%lf",label_center_x);
    //self.Label.text = [[NSString alloc] initWithFormat:@"%.3f",label_center_x ];
    
        [[self.buttonArray objectAtIndex:i] setCenter:CGPointMake(label_center_x,self.posY-yOffset)];
        [[self.buttonArray objectAtIndex:i] setTitle:[nameArray objectAtIndex:i] forState:UIControlStateNormal];
        
        UILabel * tmpLable = [self.labelArray objectAtIndex:i];
        tmpLable.text = [[NSString alloc] initWithFormat:@"%.3fkm", lablelDistance];
        [tmpLable setCenter:CGPointMake(label_center_x,self.posY+40-yOffset)];
    }
    
}

// update CoreMotion
-(void)updateDeviceMotion
{
    CMDeviceMotion *deviceMotion = self.motionManager.deviceMotion;
    
    if(deviceMotion == nil)
    {
        return;
    }
    
    // Get the attitude from CMDeviceMotion
    CMAttitude *attitude = deviceMotion.attitude;
    
    float roll = attitude.roll;
    //    float pitch = attitude.pitch;
    //    float yaw = attitude.yaw;
    
    //    float accX = userAcceleration.x;
    //    float accY = userAcceleration.y;
    //    float accZ = userAcceleration.z;
    
    
    //   roll代表着当前屏幕水平方向的转角
    roll = -(roll + 1.5);
    //    NSLog(@"roll : %f",roll);
    self.posY = self.screenwidth/2 + (roll/0.5) * (self.screenwidth/2);
    
}



- (void) touchLabel:(UIButton*)sender
{
    NSString* name = [self.imageNameArray objectAtIndex:sender.tag];
    NSLog(@"%@",name);
    NSString* string = @".png";
    NSString* buildingname = [name stringByAppendingString:string];
    self.buildingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buildingbtn.frame = CGRectMake(0,0,self.screenheight,self.screenwidth);
    [self.buildingbtn setImage:[UIImage imageNamed:buildingname] forState:UIControlStateNormal];
    
    self.buildingbtn.userInteractionEnabled = YES;
    
    UIGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(UesrClicked:)];
    [self.buildingbtn  addGestureRecognizer:singleTap];
    [self.view addSubview:self.buildingbtn];
    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults setObject: [buildingArray objectAtIndex:sender.tag] forKey:@"haha"];
    //[defaults synchronize];
    Building* b = [buildingArray objectAtIndex:sender.tag];
    
    GlobalData.lon = b.lon;
    GlobalData.lat = b.lat;
    
    
    
}

-(void) UesrClicked: (UITapGestureRecognizer *)sender{
    // self.buildingbtn.hidden=YES;
    
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"tourguideViewController"]]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}

- (void)loadSetting
{
    [self loadView];
    self.cameraController=[[cameraController alloc]init];
    [self.cameraController addDevice];
    [self.cameraController addVideoPreviewLayer];
    [self.cameraController setLandscapeRight];
    [[self.view layer] addSublayer:[self.cameraController previewLayer]];
    [self.cameraController.session startRunning];
    
}

- (void)loadView {

    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)];

    self.upperView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)];
    
    self.view.userInteractionEnabled = YES;
    self.upperView.userInteractionEnabled = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


