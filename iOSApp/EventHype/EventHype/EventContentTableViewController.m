//
//  EventContentTableViewController.m
//  EventHype
//
//  Created by Jonnathan Petote on 3/8/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import "EventContentTableViewController.h"
#import "EventAnnotation.h"
#import <MapKit/MapKit.h>

@interface EventContentTableViewController ()


@end

@implementation EventContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    self.title = @"Detail";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    // Configure the cell...
    if (indexPath.row == 0) {
        NSString *eventImageTitle = @"eventContentImage";
        cell = [tableView dequeueReusableCellWithIdentifier:@"contentImage" forIndexPath:indexPath];
        cell.userInteractionEnabled = NO;
        UIImage *image = [UIImage imageNamed:eventImageTitle];
        UIImageView *contentimg = (UIImageView *)[cell viewWithTag:1];
        contentimg.image = image;
        
    }else if(indexPath.row == 1) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"DishHashTag" forIndexPath:indexPath];
        cell.userInteractionEnabled = NO;
        UILabel *dateLabel = (UILabel *)[cell viewWithTag:2];
        UILabel *hashTagLabel = (UILabel *)[cell viewWithTag:3];
        //startDate
        //NSString *dateString = @"POSTED FEBRUARY 4, 2017";
        NSString *dateString = self.myEvent.startDate;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date  = [dateFormatter dateFromString:dateString];
        
        // Convert to new Date Format
        [dateFormatter setDateFormat:@"MMMM dd, yyyy"];
        NSString *newDate = [dateFormatter stringFromDate:date];
        NSString *postedString = [NSString stringWithFormat:@"POSTED: %@",newDate];
        
        
        NSString *hashTagString = [NSString stringWithFormat:@"#%@",self.myEvent.category];
        dateLabel.text = postedString;
        dateLabel.font = [dateLabel.font fontWithSize:14];
        hashTagLabel.text = hashTagString;
        hashTagLabel.font = [hashTagLabel.font fontWithSize:14];
        
    }else if (indexPath.row == 2) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"eventTitle" forIndexPath:indexPath];
        cell.userInteractionEnabled = NO;
        UILabel *titleLabel = (UILabel *)[cell viewWithTag:4];
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.numberOfLines = 0;
        NSString *eventTitle = self.myEvent.eventName;
        titleLabel.text = eventTitle;
        titleLabel.font = [titleLabel.font fontWithSize:26];
        
    }else if (indexPath.row == 3) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"eventContent" forIndexPath:indexPath];
        cell.userInteractionEnabled = NO;
        UILabel *contentLabel = (UILabel *)[cell viewWithTag:5];
        contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        contentLabel.numberOfLines = 0;
        NSString *eventContent = self.myEvent.eventDescription;
        contentLabel.text = eventContent;
        contentLabel.font = [contentLabel.font fontWithSize:14];
        
    }else if (indexPath.row == 4) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"eventAddress" forIndexPath:indexPath];
        cell.userInteractionEnabled = NO;
        UIImageView *pinImage = (UIImageView *)[cell viewWithTag:6];
        UILabel *addressLabel = (UILabel *)[cell viewWithTag:7];
        NSString *pinAddressString = @"pin";
        NSString *eventAddressString = self.myEvent.eventAddress;
        addressLabel.text = eventAddressString;
        addressLabel.font = [addressLabel.font fontWithSize:14];
        pinImage.image = [UIImage imageNamed:pinAddressString];
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"eventMap" forIndexPath:indexPath];
        cell.userInteractionEnabled = NO;
        MKMapView *mapView = (MKMapView*)[cell viewWithTag:8];
        
        //Takes a center point and a span in miles (converted from meters using above method)
        CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake([self.myEvent.latitude doubleValue],[self.myEvent.longitude doubleValue]);
        MKCoordinateRegion coordinateRegion = MKCoordinateRegionMakeWithDistance(startCoord, 500,500);
        
        [mapView setRegion:coordinateRegion animated:YES];
        
        EventAnnotation *eventAnnotation = [[EventAnnotation alloc]initWithEvent:self.myEvent];
        eventAnnotation.annotationView.enabled = NO;
        [mapView addAnnotation:eventAnnotation];
        
    }
    
    
    return cell;
}



@end
