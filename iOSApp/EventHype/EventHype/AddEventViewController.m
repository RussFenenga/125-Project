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


@interface AddEventViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>

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
@property (nonatomic) NSString *StartDate;
@property (nonatomic) NSString *EndDate;
@property (nonatomic) NSString *Price;
@property (nonatomic) NSString *Tag;

@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addNewEventButton.layer.cornerRadius = 10; // this value vary as per your desire
    self.addNewEventButton.clipsToBounds = YES;
    [self.addNewEventButton setEnabled:NO];
    self.imagePicker.delegate = self;
    self.eventCreationTableView.dataSource = self;
    self.eventCreationTableView.delegate = self;
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
    //make a call to our data loading class to post the event on completetion block dismiss the controller.
    [self dismissViewControllerAnimated:YES completion:nil];
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
                
                break;
            case 4:
                expandingCell = [self.eventCreationTableView dequeueReusableCellWithIdentifier:@"EndDateCell" forIndexPath:indexPath];
                expandingCell.DateLabel.text = expandingCell.DateLabel.text;
                break;
            default:
                break;
        }
        return expandingCell;
        
    } else {
        AddEventTableViewCell *cell;
        switch (indexPath.row) {
            case 0:
                 cell = [self.eventCreationTableView dequeueReusableCellWithIdentifier:@"NameCell" forIndexPath:indexPath];
                [cell.textField setPlaceholder:@"Name"];
                break;
            case 1:
                cell = [self.eventCreationTableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
                [cell.textField setPlaceholder:@"Location"];
                break;
            case 2:
                cell = [self.eventCreationTableView dequeueReusableCellWithIdentifier:@"DescriptionCell" forIndexPath:indexPath];
                [cell.textField setPlaceholder:@"Description"];
                break;
            case 5:
                cell = [self.eventCreationTableView dequeueReusableCellWithIdentifier:@"PriceCell" forIndexPath:indexPath];
                [cell.textField setPlaceholder:@"Price"];
                [cell.textField setKeyboardType:UIKeyboardTypeDecimalPad];
                break;
            case 6:
                cell = [self.eventCreationTableView dequeueReusableCellWithIdentifier:@"TagCell" forIndexPath:indexPath];
                [cell.textField setPlaceholder:@"Tag"];
                break;
            default:
                break;
        }
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
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

@end
