//
//  AddEventViewController.m
//  EventHype
//
//  Created by Russ Fenenga on 3/7/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import "AddEventViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AddEventTableViewCell.h"
#import "AddEventExpandableTableViewCell.h"
#import "Event.h"
#import "EventDataLoader.h"


@interface AddEventViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource,EventCellDoneEditingDelegate>

- (IBAction)cancelAddEvent:(UIBarButtonItem *)sender;
- (IBAction)addNewEvent:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIButton *addNewEventButton;

- (IBAction)addEventPhotoButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addNewPhotoButton;

@property UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *eventCreationTableView;


@property (nonatomic) NSString *name;
@property (nonatomic) NSString *Description;
@property (nonatomic) NSString *Location;
@property (nonatomic) NSString *lat;
@property (nonatomic) NSString *lon;
@property (nonatomic) NSString *StartDate;
@property (nonatomic) NSString *EndDate;
@property (nonatomic) NSString *Price;
@property (nonatomic) NSString *Tag;

@property EventDataLoader *dataLoader;

@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addNewEventButton.layer.cornerRadius = 10; // this value vary as per your desire
    self.addNewEventButton.clipsToBounds = YES;
    self.imagePicker.delegate = self;
    self.eventCreationTableView.dataSource = self;
    self.eventCreationTableView.delegate = self;
    self.dataLoader = [EventDataLoader sharedManager];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillHide:)
     name:UIKeyboardWillHideNotification
     object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)cancelAddEvent:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addNewEvent:(UIButton *)sender {
    
    
    if([self isValidInput]){
        Event *newEvent = [[Event alloc] init];
        newEvent.idNumber = arc4random_uniform(INT_MAX);
        newEvent.eventName = self.name;
        newEvent.eventDescription = self.Description;
        newEvent.eventAddress = self.Location;
        newEvent.latitude = self.lat;
        newEvent.longitude = self.lon;
        
        NSRange rng = [self.StartDate rangeOfString:@" "];
        NSString *first = [self.StartDate substringToIndex:rng.location];
        NSString *last = [self.StartDate substringFromIndex:rng.location + 1];
        
        newEvent.startDate = first;
        newEvent.startTime = last;
        
        NSRange rng2 = [self.EndDate rangeOfString:@" "];
        NSString *first2 = [self.EndDate substringToIndex:rng2.location];
        NSString *last2 = [self.EndDate substringFromIndex:rng2.location + 1];

        
        
        newEvent.endDate = first2;
        newEvent.endTime = last2;
        
        newEvent.price = self.Price;
        newEvent.category = self.Tag;
        
        newEvent.createdAt = [[NSDate date] description];
        newEvent.updatedAt = [[NSDate date] description];
        
        newEvent.subcategory = @"";
        newEvent.url = @"";
        newEvent.sourceUrl = @"";
        newEvent.logoURL = @"";
        
        //make a call to our data loading class to post the event on completetion block dismiss the controller.
        
        [self.dataLoader sendEvent:newEvent];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Missing Field"
                                     message:@"Please fill out all fields then try again."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        
        UIAlertAction* okay = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                   }];
        
        [alert addAction:okay];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)addEventPhotoButton:(UIButton *)sender {
    [self promptForSource];
    [self.addNewEventButton setEnabled:YES];
}

- (void)promptForSource{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add photo" message:@"Take or select a photo that describes your event." preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *TakePhoto = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [self handleCamera];
    }];
    UIAlertAction *ChoosePhoto = [UIAlertAction actionWithTitle:@"Choose Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [self handleImageGallery];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:TakePhoto];
    [alert addAction:ChoosePhoto];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)handleCamera {
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)handleImageGallery {
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    if(userInfo != NULL){
        CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat height = rect.size.height;
        self.eventCreationTableView.contentInset = UIEdgeInsetsMake(0, 0, height, 0);
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [UIView animateWithDuration:0.2 animations:^{
        self.eventCreationTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }];
}

#pragma mark - TableView Delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}



- (UITableViewCell *)tableView:(UITableView *)tableViewcell cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.row == 3 || indexPath.row == 4){
        AddEventExpandableTableViewCell *expandingCell;
        switch (indexPath.row) {
            case 3:
                expandingCell = [self.eventCreationTableView dequeueReusableCellWithIdentifier:@"StartDateCell" forIndexPath:indexPath];
                expandingCell.DateLabel.text = expandingCell.DateLabel.text;
                expandingCell.index = 3;
                break;
            case 4:
                expandingCell = [self.eventCreationTableView dequeueReusableCellWithIdentifier:@"EndDateCell" forIndexPath:indexPath];
                //expandingCell.DateLabel.text = expandingCell.DateLabel.text;
                expandingCell.index = 4;
                expandingCell.DateLabel.text = @"End Date:";
                break;
            default:
                break;
        }
        expandingCell.delegate = self;
        return expandingCell;
        
    } else {
        AddEventTableViewCell *cell;
        switch (indexPath.row) {
            case 0:
                 cell = [self.eventCreationTableView dequeueReusableCellWithIdentifier:@"NameCell" forIndexPath:indexPath];
                [cell.textField setPlaceholder:@"Name"];
                cell.index = 0;
                break;
            case 1:
                cell = [self.eventCreationTableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
                [cell.textField setPlaceholder:@"Location"];
                cell.index = 1;
                break;
            case 2:
                cell = [self.eventCreationTableView dequeueReusableCellWithIdentifier:@"DescriptionCell" forIndexPath:indexPath];
                [cell.textField setPlaceholder:@"Description"];
                cell.index = 2;
                break;
            case 5:
                cell = [self.eventCreationTableView dequeueReusableCellWithIdentifier:@"PriceCell" forIndexPath:indexPath];
                [cell.textField setPlaceholder:@"Price"];
                [cell.textField setKeyboardType:UIKeyboardTypeDecimalPad];
                cell.index = 5;
                break;
            case 6:
                cell = [self.eventCreationTableView dequeueReusableCellWithIdentifier:@"TagCell" forIndexPath:indexPath];
                [cell.textField setPlaceholder:@"Tag"];
                cell.index = 6;
                break;
            default:
                break;
        }
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 3 || indexPath.row == 4){
        return 250;
    } else
        return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - Image picker controller delegate methods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSData *dataImage = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],1);
    UIImage *img = [[UIImage alloc] initWithData:dataImage];
    self.imageView.image = nil;
    [self.imageView setImage:img];
    [self.imageView sizeToFit];
    
    //essentially hide the button but we still want it to register touch events
    self.addNewPhotoButton.backgroundColor = [UIColor clearColor];
    [self.addNewPhotoButton setTitle:@"" forState:UIControlStateNormal];
    
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - Cell Delegate Methods

-(void)cellFinishedEditingAndIsFilled:(BOOL)filled withData:(NSString *)data fromIndex:(int)index {
    if(filled){
        switch (index) {
            case 0:
                self.name = data;
                break;
            case 1:
                self.Location = data;
                //we calculate lat lon in the data model when we make the request
                break;
            case 2:
                self.Description = data;
                break;
            case 5:
                self.Price = data;
                break;
            case 6:
                self.Tag = data;
                break;
            default:
                break;
        }
    }
}

-(void)expandableCellFinishedEditingAndIsFilled:(BOOL)filled withData:(NSString *)data fromIndex:(int)index{
        switch (index) {
            case 3:
                self.StartDate = data;
                break;
            case 4:
                self.EndDate = data;
                break;
            default:
                break;
        }
}

-(BOOL)isValidInput{
    if(self.name.length == 0 || self.Description.length == 0 ||self.Location.length == 0 ||self.StartDate.length == 0 ||self.EndDate.length == 0 || self.Price.length == 0 || self.Tag.length == 0){
        return false;
    } else {
        return true;
    }
}
@end
