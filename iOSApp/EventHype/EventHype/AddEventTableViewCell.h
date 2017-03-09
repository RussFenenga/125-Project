//
//  AddEventTableViewCell.h
//  EventHype
//
//  Created by Russ Fenenga on 3/8/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
@interface AddEventTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;
- (IBAction)textFieldDoneEditing:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
