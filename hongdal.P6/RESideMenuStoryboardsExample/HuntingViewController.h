//
//  HuntingViewController.h
//  RESideMenuStoryboardsExample
//
//  Created by Zian Chen on 11/10/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cameraController.h"
#import "LabelView.h"
#import "Measure.h"

#import "DB.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreMotion/CoreMotion.h>  //library for detecting vertical direction

#import "RESideMenu.h"

//#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface HuntingViewController : UIViewController<MKMapViewDelegate,  CLLocationManagerDelegate> {

    //CLLocationCoordinate2D  currentLocation;
    // current heading
    CLLocationDirection     currentHeading;
    
    UIScreen *currentScreen;


    
}
    
    
@property (nonatomic, strong) cameraController *cameraController;
@property (nonatomic, strong) UIView * upperView;
@property (nonatomic, strong) UILabel * Label;
@property (nonatomic, strong) NSMutableArray *buttonArray;

//property for mapkit service delegate and CLLocation manager
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@property (nonatomic) CLLocationDirection currentHeading;
@property (nonatomic, strong) Measure* measure;
//@property (strong, nonatomic) DB *db;
@property (strong, nonatomic) NSMutableArray * nameArray;
@property (strong, nonatomic) NSMutableArray * latArray;
@property (strong, nonatomic) NSMutableArray * lonArray;
@property (nonatomic, strong) NSMutableArray * labelArray;

@property (strong, nonatomic) NSMutableArray * buildingArray;

@property (nonatomic, strong) UIButton * buildingbtn;
@property(nonatomic)float screenwidth;
@property(nonatomic)float screenheight;
@property(nonatomic)double mylat;
@property(nonatomic)double mylon;
@property (nonatomic, strong) NSMutableArray * imageNameArray;
@property (strong,nonatomic) CMMotionManager * motionManager;  //manager for vertical direction
@property (nonatomic) double posY;


@end




