//
//  EventDataLoader.h
//  EventHype
//
//  Created by Russ Fenenga on 3/13/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@protocol EventLoadingDelegate <NSObject>

-(void)sendEventData:(NSArray *)array;
-(void)eventSavedToDatabase:(Event *)event;

@end


@interface EventDataLoader : NSObject

@property(nonatomic,assign)id delegate;

+ (id)sharedManager;

-(void)loadAllEvents;
-(void)sendEvent:(Event*) eventToSend;

@end
