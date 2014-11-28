//
//  settingTable.h
//  tipCalc
//
//  Created by Arnaud Crowther on 12/9/13.
//  Copyright (c) 2013 Arnaud Crowther. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *customTip;
extern BOOL cstmTip;
extern NSString *billSplitNum;
extern BOOL billSplit;
extern NSString *customTax;
extern BOOL cstmTax;
extern BOOL sumit;
extern BOOL muteBeep;

@interface settingTable : UITableViewController <UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate>
{
    NSArray *options;
    NSArray *states;
    NSString *customTaxShort;

    IBOutlet UIPickerView *picker;
    IBOutlet UISwitch *switcher;
    
    IBOutlet UITextField *txtCustTip;
    IBOutlet UITextField *txtCustTax;
    IBOutlet UITextField *txtBillSplit;

    IBOutlet UITableViewCell *cellone;
    IBOutlet UITableViewCell *celltwo;
    IBOutlet UITableViewCell *cellthree;
}

- (IBAction)doneBtn:(id)sender;
- (IBAction)switcher:(id)sender;
- (IBAction)sliderBill:(id)sender;
- (IBAction)DidEndEditBill:(id)sender;
- (IBAction)infoTax:(id)sender;
- (IBAction)didEndEditTip:(id)sender;




@end
