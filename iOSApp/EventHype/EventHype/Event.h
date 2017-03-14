//
//  Event.h
//  EventHype
//
//  Created by Russ Fenenga on 3/13/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface Event : NSObject

-(id)initWithParameters:(NSDictionary *)parameters;


@property (nonatomic) long idNumber;
@property (nonatomic,strong) NSString *eventName;
@property (nonatomic,strong) NSString *eventDescription;
@property (nonatomic,strong) NSString *eventAddress;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *category;
@property (nonatomic,strong) NSString *subcategory;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *sourceUrl;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *logoURL;
@property (nonatomic,strong) NSString *startDate;
@property (nonatomic,strong) NSString *startTime;
@property (nonatomic,strong) NSString *endDate;
@property (nonatomic,strong) NSString *endTime;
@property (nonatomic,strong) NSString *createdAt;
@property (nonatomic,strong) NSString *updatedAt;

@end
