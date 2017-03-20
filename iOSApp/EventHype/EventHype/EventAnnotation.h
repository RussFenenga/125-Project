//
//  EventAnnotation.h
//  EventHype
//
//  Created by Russ Fenenga on 3/20/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
@import MapKit;

@interface EventAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) Event *event;

-(id)initWithEvent:(Event *)event;
-(MKAnnotationView *)annotationView;

@end
