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

@end
