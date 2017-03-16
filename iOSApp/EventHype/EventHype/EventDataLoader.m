//
//  EventDataLoader.m
//  EventHype
//
//  Created by Russ Fenenga on 3/13/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import "EventDataLoader.h"

@implementation EventDataLoader


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
                    [arrayOfEventObjects addObject:event];
                }
                [self.delegate sendEventData: arrayOfEventObjects];
            }
        }
    }] resume];
}

-(void)sendEvent:(Event*) eventToSend {

    NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    /* Create session, and optionally set a NSURLSessionDelegate. */
    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
    
    
    NSURL* URL = [NSURL URLWithString:@"http://eventhype.me/api/events"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    
    // Form URL-Encoded Body
    eventToSend.dictOfKeysAndValues = @{@"id": @(eventToSend.idNumber), @"event_name":eventToSend.eventName,@"event_description":eventToSend.eventDescription,@"event_address":eventToSend.eventAddress,@"latitude":eventToSend.latitude,@"longitude":eventToSend.longitude,@"category":eventToSend.category,@"subcategory":eventToSend.subcategory,@"url":eventToSend.url,@"source":eventToSend.sourceUrl,@"price":eventToSend.price,@"logo":eventToSend.logoURL,@"start_date":eventToSend.startDate,@"start_time":eventToSend.startTime,@"end_date":eventToSend.endDate,@"end_time":eventToSend.endTime,@"created_at":eventToSend.createdAt,@"updated_at":eventToSend.updatedAt};
    
    NSDictionary* bodyParameters = eventToSend.dictOfKeysAndValues;
    request.HTTPBody = [NSStringFromQueryParameters(bodyParameters) dataUsingEncoding:NSUTF8StringEncoding];
    
    /* Start a new Task */
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            // Success
            NSLog(@"URL Session Task Succeeded: HTTP %ld", ((NSHTTPURLResponse*)response).statusCode);
        }
        else {
            // Failure
            NSLog(@"URL Session Task Failed: %@", [error localizedDescription]);
        }
    }];
    [task resume];
}

/*
 * Utils: Add this section before your class implementation
 */

/**
 This creates a new query parameters string from the given NSDictionary. For
 example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
 string will be @"day=Tuesday&month=January".
 @param queryParameters The input dictionary.
 @return The created parameters string.
 */
static NSString* NSStringFromQueryParameters(NSDictionary* queryParameters)
{
    NSMutableArray* parts = [NSMutableArray array];
    for(id key in queryParameters){
        id val = [queryParameters objectForKey:key];
        NSString *value;
        if (![val isMemberOfClass:[NSString class]]){
            value = [NSString stringWithFormat:@"%lu", (long)val];
        } else {
            value = val;
        }
        NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
        NSString *part = [NSString stringWithFormat: @"%@=%@",
                          [key stringByAddingPercentEncodingWithAllowedCharacters:set],
                          [value stringByAddingPercentEncodingWithAllowedCharacters:set]
                          ];
        [parts addObject:part];
    }
    return [parts componentsJoinedByString: @"&"];
}

/**
 Creates a new URL by adding the given query parameters.
 @param URL The input URL.
 @param queryParameters The query parameter dictionary to add.
 @return A new NSURL.
 */
static NSURL* NSURLByAppendingQueryParameters(NSURL* URL, NSDictionary* queryParameters)
{
    NSString* URLString = [NSString stringWithFormat:@"%@?%@",
                           [URL absoluteString],
                           NSStringFromQueryParameters(queryParameters)
                           ];
    return [NSURL URLWithString:URLString];
}

@end
