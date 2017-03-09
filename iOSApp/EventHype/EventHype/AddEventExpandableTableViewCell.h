//
//  AddEventExpandableTableViewCell.h
//  EventHype
//
//  Created by Russ Fenenga on 3/9/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"

@interface AddEventExpandableTableViewCell : UITableViewCell
- (IBAction)datePickerValueChanged:(UIDatePicker *)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;
@end
