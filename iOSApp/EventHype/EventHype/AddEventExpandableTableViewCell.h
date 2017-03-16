//
//  AddEventExpandableTableViewCell.h
//  EventHype
//
//  Created by Russ Fenenga on 3/9/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"

@protocol ExpandableEventCellDoneEditingDelegate <NSObject>

-(void)expandableCellFinishedEditingAndIsFilled:(BOOL)filled withData:(NSString *)data fromIndex:(int)index;

@end

@interface AddEventExpandableTableViewCell : UITableViewCell
@property(nonatomic,assign)id delegate;
- (IBAction)datePickerValueChanged:(UIDatePicker *)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;
@property int index;

@end
