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



/*
 
 UIImageView *eventImage;
 UILabel *eventDateLabel;
 UILabel *eventHashTagLabel;
 UILabel *eventTitleLabel;
 UILabel *eventContent;
 UIImageView *eventAddressPinImage;
 UILabel *eventAddressLabel;
 
 */


@end

@implementation EventContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
        
        NSString *dateString = @"POSTED FEBRUARY 4, 2017";
        NSString *hashTagString = [NSString stringWithFormat:@"#%@",self.myEvent.category];
        dateLabel.text = dateString;
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
        contentLabel.font = [contentLabel.font fontWithSize:12];
        
    }else if (indexPath.row == 4) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"eventAddress" forIndexPath:indexPath];
        cell.userInteractionEnabled = NO;
        UIImageView *pinImage = (UIImageView *)[cell viewWithTag:6];
        UILabel *addressLabel = (UILabel *)[cell viewWithTag:7];
        NSString *pinAddressString = @"pin";
        NSString *eventAddressString = self.myEvent.eventAddress;
        addressLabel.text = eventAddressString;
        addressLabel.font = [addressLabel.font fontWithSize:12];
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
        

        
        /*
         MKMapView *mapView = (MKMapView*)[cell viewWithTag:2];
         
         //Takes a center point and a span in miles (converted from meters using above method)
         CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(37.766997, -122.422032);
         MKCoordinateRegion adjustedRegion = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, MilesToMeters(0.5f), MilesToMeters(0.5f))];
         [mapView setRegion:adjustedRegion animated:YES];
         
         MKCoordinateRegion coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 500,500);
         [self.eventMapView setRegion:coordinateRegion];
         
         */
        
        NSLog(@"ELSE CASEEEE YOOOO\n");
        
    }
    
    
    return cell;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // Configure the cell...
    
    _eventImage.image =
    
    
    return cell;
}*/


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
