//
//  ViewController.m
//  EventHype
//
//  Created by Russ Fenenga on 3/5/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Event.h"
#import "EventDataLoader.h"

@import MapKit;

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate, EventLoadingDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *eventMapView;
@property CLLocationManager *locationManager;
@property EventDataLoader *dataLoader;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.eventMapView.delegate = self;
    self.dataLoader = [EventDataLoader sharedManager];
    self.dataLoader.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    self.eventMapView.userTrackingMode = MKUserTrackingModeFollow;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.dataLoader loadAllEvents];
}


#pragma mark EventLoadingDelegateMethods

-(void)eventSavedToDatabase:(Event *)event{
    CLLocationCoordinate2D pinlocation;
    
    CLLocationDegrees eventLat = [event.latitude doubleValue];
    CLLocationDegrees eventLong = [event.longitude doubleValue];
    
    pinlocation.latitude = eventLat ;//set latitude of selected coordinate ;
    pinlocation.longitude = eventLong ;//set longitude of selected coordinate;
    
    // Create Annotation point
    MKPointAnnotation *Pin = [[MKPointAnnotation alloc]init];
    Pin.coordinate = pinlocation;
    Pin.title = event.eventName;
    
    [self.eventMapView addAnnotation:Pin];
}

-(void)sendEventData:(NSArray *)array {
    NSMutableArray *allPins = [[NSMutableArray alloc] init];
    for(Event *event in array){
        // Define pin location
        CLLocationCoordinate2D pinlocation;
        
        CLLocationDegrees eventLat = [event.latitude doubleValue];
        CLLocationDegrees eventLong = [event.longitude doubleValue];
        
        pinlocation.latitude = eventLat ;//set latitude of selected coordinate ;
        pinlocation.longitude = eventLong ;//set longitude of selected coordinate;
        
        // Create Annotation point
        MKPointAnnotation *Pin = [[MKPointAnnotation alloc]init];
        Pin.coordinate = pinlocation;
        Pin.title = event.eventName;
        
        [allPins addObject:Pin];
    }
    [self.eventMapView addAnnotations:allPins];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
