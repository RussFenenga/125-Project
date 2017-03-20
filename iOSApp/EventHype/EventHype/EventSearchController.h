//
//  EventSearchController.h
//  EventHype
//
//  Created by Russ Fenenga on 3/20/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventSearchController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *allEventsBeingSearched;
@property (strong, nonatomic) NSArray *filteredEvents;
@end
