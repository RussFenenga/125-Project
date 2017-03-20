//
//  EventAnnotation.m
//  EventHype
//
//  Created by Russ Fenenga on 3/20/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import "EventAnnotation.h"

@implementation EventAnnotation

-(id)initWithEvent:(Event *)event{
    self = [super init];
    if(self){
        self.title = event.eventName;
        self.event = event;
        
        self.coordinate = CLLocationCoordinate2DMake([event.latitude doubleValue],[event.longitude doubleValue]);
    }
    return self;
}

-(MKAnnotationView *)annotationView {
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"EventAnnotation"];
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.image = [UIImage imageNamed:@"pin"];
    annotationView.centerOffset = CGPointMake(0, -annotationView.image.size.height / 2);
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}


@end
