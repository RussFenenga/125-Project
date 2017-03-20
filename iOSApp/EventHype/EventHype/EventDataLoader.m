//
//  EventDataLoader.m
//  EventHype
//
//  Created by Russ Fenenga on 3/13/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import "EventDataLoader.h"

@implementation EventDataLoader

+ (id)sharedManager {
    static EventDataLoader *dataLoader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataLoader = [[self alloc] init];
    });
    return dataLoader;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}


-(void)loadAllEvents {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://eventhype.me/api/events"]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",strData);
        if(data != NULL){
            NSError *jsonError;
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if(jsonError) {
                // check the error description
                NSLog(@"json error : %@", [jsonError localizedDescription]);
            } else {
                NSMutableArray *arrayOfEventObjects = [[NSMutableArray alloc] init];
                for(NSDictionary *eventDict in array){
                    Event *event = [[Event alloc] initWithParameters:eventDict];
                    if(![event.latitude isEqualToString:@""] && ![event.longitude isEqualToString:@""])
                        [arrayOfEventObjects addObject:event];
                }
                [self.delegate sendEventData: arrayOfEventObjects];
            }
        }
    }] resume];
}

-(void)sendEvent:(Event*) eventToSend{

    NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    /* Create session, and optionally set a NSURLSessionDelegate. */
    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];

    // Form URL-Encoded Body
    eventToSend.dictOfKeysAndValues = @{@"id": @(eventToSend.idNumber), @"event_name":eventToSend.eventName,@"event_description":eventToSend.eventDescription,@"event_address":eventToSend.eventAddress,@"latitude":eventToSend.latitude,@"longitude":eventToSend.longitude,@"category":eventToSend.category,@"subcategory":eventToSend.subcategory,@"url":eventToSend.url,@"source":eventToSend.sourceUrl,@"price":eventToSend.price,@"logo":eventToSend.logoURL,@"start_date":eventToSend.startDate,@"start_time":eventToSend.startTime,@"end_date":eventToSend.endDate,@"end_time":eventToSend.endTime,@"created_at":eventToSend.createdAt,@"updated_at":eventToSend.updatedAt};
    
    NSString *baseString = @"http://eventhype.me/api/event/insert?";
    int count = 0;
    
    for(NSString* key in eventToSend.dictOfKeysAndValues){
        count++;
        if(![key isEqual:@"id"]){
            if(![[eventToSend.dictOfKeysAndValues valueForKey:key] isEqualToString:@""]){
                baseString = [baseString stringByAppendingString:key];
                NSString *encodedString = [[eventToSend.dictOfKeysAndValues valueForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
                if(count != [eventToSend.dictOfKeysAndValues count]){
                    NSString *valueString = [NSString stringWithFormat:@"=%@&",encodedString];
                    baseString = [baseString stringByAppendingString:valueString];
                } else {
                    NSString *valueString = [NSString stringWithFormat:@"=%@",encodedString];
                    baseString = [baseString stringByAppendingString:valueString];
                }
            }
        } else if([key isEqual:@"id"]) {
            baseString = [baseString stringByAppendingString:key];
            int temp = [[eventToSend.dictOfKeysAndValues valueForKey:key] intValue];
            NSString *numberString = [NSString stringWithFormat:@"%d",temp];
            NSString *encodedString = [numberString  stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
            if(count != [eventToSend.dictOfKeysAndValues count]){
                NSString *valueString = [NSString stringWithFormat:@"=%@&",encodedString];
                baseString = [baseString stringByAppendingString:valueString];
            } else {
                NSString *valueString = [NSString stringWithFormat:@"=%@",encodedString];
                baseString = [baseString stringByAppendingString:valueString];
            }
        }
        
    }
    
    
    NSURL* baseURL = [[NSURL alloc] initWithString:baseString];
    

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:baseURL];
    request.HTTPMethod = @"GET";
    
    /* Start a new Task */
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            // Success
            NSLog(@"URL Session Task Succeeded: HTTP %ld", ((NSHTTPURLResponse*)response).statusCode);
            [self.delegate eventSavedToDatabase:eventToSend];
        }
        else {
            // Failure
            NSLog(@"URL Session Task Failed: %@", [error localizedDescription]);
        }
    }];
    [task resume];
}
@end
