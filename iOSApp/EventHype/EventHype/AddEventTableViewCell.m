//
//  AddEventTableViewCell.m
//  EventHype
//
//  Created by Russ Fenenga on 3/8/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import "AddEventTableViewCell.h"

@implementation AddEventTableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.textField.text = self.textField.text;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.checkBox setOnAnimationType:BEMAnimationTypeOneStroke];
    self.textField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)textFieldDoneEditing:(UITextField *)sender {
    if([self.textField.text  isEqual: @""]){
        [self.checkBox setOn:NO animated:YES];
    } else if(![self.checkBox on]) {
        [self.checkBox setOn:YES animated:YES];
    }
}
@end
