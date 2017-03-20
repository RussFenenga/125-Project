//
//  EventSearchController.m
//  EventHype
//
//  Created by Russ Fenenga on 3/20/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import "EventSearchController.h"
#import "Event.h"
#import "EventContentTableViewController.h"

@interface EventSearchController()


@end

@implementation EventSearchController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Search";
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark table view

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return [self.filteredEvents count];
    } else {
        return 0; //we don't want to show all the events
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    Event *event;
    
    if(tableView == self.searchDisplayController.searchResultsTableView){
        event = self.filteredEvents[indexPath.row];
    } else {
        //event = self.allEventsBeingSearched[indexPath.row];
    }
    cell.textLabel.text = event.eventName;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Event *eventSelected;
    
    if(tableView == self.searchDisplayController.searchResultsTableView){
        eventSelected = self.filteredEvents[indexPath.row];
        NSLog(@"%@",eventSelected.eventName);
        // Get the storyboard named secondStoryBoard from the main bundle:
        UIStoryboard *eventContentStoryboard = [UIStoryboard storyboardWithName:@"EventContent" bundle:nil];
        
        // Load the initial view controller from the storyboard.
        // Set this by selecting 'Is Initial View Controller' on the appropriate view controller in the storyboard.
        EventContentTableViewController *eventContent = [eventContentStoryboard instantiateInitialViewController];
        
        eventContent.myEvent = eventSelected;
        
        UIStoryboardSegue *segue = [UIStoryboardSegue segueWithIdentifier:@"ToContent" source:self destination:eventContent performHandler:^(void) {
            //view transition/animation
            [self.navigationController pushViewController:eventContent animated:YES];
        }];
        [self prepareForSegue:segue sender:self];
        [segue perform];
    } else {
        //eventSelected = self.allEventsBeingSearched[indexPath.row];
    }
}


#pragma mark Search

-(void)filterContentForSearchText:(NSString *)searchText{
    self.filteredEvents = self.allEventsBeingSearched;
    self.filteredEvents = [self.allEventsBeingSearched filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Event *event, NSDictionary *bindings) {
        NSRange matchOnEventName = [event.eventName rangeOfString:searchText options:NSCaseInsensitiveSearch];
        NSRange matchOnTag = [event.category rangeOfString:searchText options:NSCaseInsensitiveSearch];
        return ((matchOnEventName.location != NSNotFound) || (matchOnTag.location != NSNotFound));
    }]];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text];
    return true;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString];
    return true;
}


@end
