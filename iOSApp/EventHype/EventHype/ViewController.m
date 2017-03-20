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
#import "EventAnnotation.h"
#import "EventContentTableViewController.h"
#import "EventSearchController.h"

@import MapKit;

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate, EventLoadingDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *eventMapView;
@property CLLocationManager *locationManager;
@property EventDataLoader *dataLoader;
@property NSMutableArray *allEvents;

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
    
    self.allEvents = [[NSMutableArray alloc] init];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    self.eventMapView.userTrackingMode = MKUserTrackingModeFollow;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.dataLoader loadAllEvents];
}
- (IBAction)searchButtonTapped:(UIBarButtonItem *)sender {
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"SearchForEvents" bundle:nil];
    
    // Load the initial view controller from the storyboard.
    // Set this by selecting 'Is Initial View Controller' on the appropriate view controller in the storyboard.
     EventSearchController *searchController = [secondStoryBoard instantiateInitialViewController];
    NSArray *allEventsForSearching =  [[NSMutableArray alloc] initWithArray:[self.allEvents copy]];
    searchController.allEventsBeingSearched = allEventsForSearching;
    searchController.filteredEvents = [allEventsForSearching copy];
    
    UIStoryboardSegue *segue = [UIStoryboardSegue segueWithIdentifier:@"ToSearch" source:self destination:searchController performHandler:^(void) {
        //view transition/animation
        [self.navigationController pushViewController:searchController animated:YES];
    }];
    [self prepareForSegue:segue sender:self];
    [segue perform];
}

#pragma mark MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if([annotation isKindOfClass:[EventAnnotation class]]){
        EventAnnotation *myEventAnnotation = (EventAnnotation *)annotation;
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"EventAnnotation"];
        if(annotationView == nil)
            annotationView = myEventAnnotation.annotationView;
        else
            annotationView.annotation = annotation;
        
        return annotationView;
        
    } else {
        
        return nil;
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    EventAnnotation *eventAnnotation = (EventAnnotation *)view.annotation;
    Event *event = eventAnnotation.event;
    
    // Get the storyboard named secondStoryBoard from the main bundle:
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"EventContent" bundle:nil];
    
    // Load the initial view controller from the storyboard.
    // Set this by selecting 'Is Initial View Controller' on the appropriate view controller in the storyboard.
    EventContentTableViewController *eventContent = [secondStoryBoard instantiateInitialViewController];
    
    eventContent.myEvent = event;
    
    UIStoryboardSegue *segue = [UIStoryboardSegue segueWithIdentifier:@"ToContent" source:self destination:eventContent performHandler:^(void) {
        //view transition/animation
        [self.navigationController pushViewController:eventContent animated:YES];
    }];
    [self prepareForSegue:segue sender:self];
    [segue perform];
}



#pragma mark EventLoadingDelegateMethods

-(void)eventSavedToDatabase:(Event *)event{
    EventAnnotation *eventAnnotation = [[EventAnnotation alloc]initWithEvent:event];
    [self.allEvents addObject:event];
    [self.eventMapView addAnnotation:eventAnnotation];
}

-(void)sendEventData:(NSArray *)array {
    NSMutableArray *allPins = [[NSMutableArray alloc] init];
    [self.allEvents removeAllObjects]; //avoids duplicate events
    for(Event *event in array){
        
        EventAnnotation *eventAnnotation = [[EventAnnotation alloc]initWithEvent:event];
        [allPins addObject:eventAnnotation];
        [self.allEvents addObject:event];
    }
    [self.eventMapView addAnnotations:allPins];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
