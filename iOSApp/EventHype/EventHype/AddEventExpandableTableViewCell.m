//
//  AddEventExpandableTableViewCell.m
//  EventHype
//
//  Created by Russ Fenenga on 3/9/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import "AddEventExpandableTableViewCell.h"

@implementation AddEventExpandableTableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.DateLabel.text = self.DateLabel.text;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.checkBox setOn:YES animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (IBAction)datePickerValueChanged:(UIDatePicker *)sender {
    [self setTime];
    [self.delegate expandableCellFinishedEditingAndIsFilled:YES withData:[self.datePicker.date description] fromIndex:self.index];
}

- (void)setTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    NSDate *todaysDate;
    todaysDate = self.datePicker.date;
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@" h:mm a"];
    
    NSString *timetofill = [outputFormatter stringFromDate:self.datePicker.date];
    
    self.DateLabel.text = [[formatter stringFromDate:todaysDate] stringByAppendingString: timetofill];
    
}
@end
