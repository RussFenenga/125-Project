//
//  Event.m
//  EventHype
//
//  Created by Russ Fenenga on 3/13/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import "Event.h"

@interface Event ()

@end


@implementation Event

//parameters is a dictionary containing
- (id)initWithParameters: (NSDictionary *)parameters {
    
    self.dictOfKeysAndValues = parameters;
    
    self.idNumber = [[parameters valueForKey:@"id"] integerValue];
    self.eventName = [parameters valueForKey:@"event_name"];
    self.eventDescription = [parameters valueForKey:@"event_description"];
    self.eventAddress = [parameters valueForKey:@"event_address"];
    
    self.latitude = [parameters valueForKey:@"latitude"];
    self.longitude = [parameters valueForKey:@"longitude"];
    
    self.category = [parameters valueForKey:@"category"];
    self.subcategory = [parameters valueForKey:@"subcategory"];
    
    self.url = [parameters valueForKey:@"url"];
    self.sourceUrl = [parameters valueForKey:@"source"];
    self.logoURL = [parameters valueForKey:@"logo"];
    
    self.price = [parameters valueForKey:@"price"];
    
    self.startTime = [parameters valueForKey:@"start_time"];
    self.startDate = [parameters valueForKey:@"start_date"];
    self.endTime = [parameters valueForKey:@"end_time"];
    self.endDate = [parameters valueForKey:@"end_date"];
    
    self.createdAt = [parameters valueForKey:@"created_at"];
    self.updatedAt = [parameters valueForKey:@"updated_at"];
    
    return self;
}

@end
