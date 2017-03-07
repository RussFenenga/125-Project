//
//  AddEventViewController.m
//  EventHype
//
//  Created by Russ Fenenga on 3/7/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import "AddEventViewController.h"

@interface AddEventViewController ()
- (IBAction)cancelAddEvent:(UIBarButtonItem *)sender;

@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelAddEvent:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
