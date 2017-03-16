//
//  AddEventTableViewCell.h
//  EventHype
//
//  Created by Russ Fenenga on 3/8/17.
//  Copyright © 2017 com.RussellFenenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"

@protocol EventCellDoneEditingDelegate <NSObject>

-(void)cellFinishedEditingAndIsFilled:(BOOL)filled withData:(NSString *)data fromIndex:(int)index;

@end

@interface AddEventTableViewCell : UITableViewCell <UITextFieldDelegate>


@property(nonatomic,assign)id delegate;
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;
- (IBAction)textFieldDoneEditing:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property int index;

@end
