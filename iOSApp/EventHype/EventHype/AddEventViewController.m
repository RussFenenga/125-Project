//
//  AddEventViewController.m
//  EventHype
//
//  Created by Russ Fenenga on 3/7/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import "AddEventViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface AddEventViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (IBAction)cancelAddEvent:(UIBarButtonItem *)sender;
- (IBAction)addNewEvent:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *addNewEventButton;

- (IBAction)addEventPhotoButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addNewPhotoButton;

@property UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addNewEventButton.layer.cornerRadius = 10; // this value vary as per your desire
    self.addNewEventButton.clipsToBounds = YES;
    [self.addNewEventButton setEnabled:NO];
    self.imagePicker.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)cancelAddEvent:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addNewEvent:(UIButton *)sender {
    
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

- (void)handleImageGallery
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}


//MARK: - Delegates

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
