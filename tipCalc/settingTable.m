//
//  settingTable.m
//  tipCalc
//
//  Created by Arnaud Crowther on 12/9/13.
//  Copyright (c) 2013 Arnaud Crowther. All rights reserved.
//

#import "settingTable.h"

@interface settingTable ()

@end

@implementation settingTable

NSString *customTip;
BOOL cstmTip = NO;
NSString *billSplitNum;
BOOL billSplit = NO;
NSString *customTax;
BOOL cstmTax;
BOOL sumit = NO;
BOOL muteBeep;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    options = @[@"1.00 %",@"2.00 %",@"3.00 %",@"4.00 %",@"5.00 %",@"6.00 %",@"7.00 %",@"8.00 %",@"9.00 %"];
    [picker selectRow:5 inComponent:0 animated:YES];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setTitle.png"]];
}

- (void)viewDidLayoutSubviews {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults valueForKey:@"tipitappdataswitchstateAAfahgq324657ixfghae"]) {//key doesnt exist
        [switcher setOn:NO];
        [self cellAlphaState:0 animated:NO];
    }
    if ([[defaults valueForKey:@"tipitappdataswitchstateAAfahgq324657ixfghae"] isEqualToString:@"ON"]) {//key is set to on
        [switcher setOn:YES];
        [self cellAlphaState:1 animated:NO];
    }
    else if ([[defaults valueForKey:@"tipitappdataswitchstateAAfahgq324657ixfghae"] isEqualToString:@"OFF"]) {//key is set to off
        [switcher setOn:NO];
        [self cellAlphaState:0 animated:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [super viewWillAppear:animated];
    if (cstmTip == YES) {
        txtCustTip.text = customTip;
    }
    cstmTip = NO;
    sumit = NO;
    if (cstmTax == YES) {
        if ([customTax integerValue] > 9) {
            [picker selectRow:8 inComponent:0 animated:YES];
        }
        else {
        NSInteger temp = [[defaults valueForKey:@"tipitappdatacustomtaxAAfahgq324657ixfghae"] integerValue] - 1;
        [picker selectRow:temp inComponent:0 animated:YES];
        }
        txtCustTax.text = [defaults valueForKey:@"tipitappdatacustomtaxAAfahgq324657ixfghae"];
        NSRange range = [[defaults valueForKey:@"tipitappdatacustomtaxAAfahgq324657ixfghae"] rangeOfString:@"%"];
        if (range.location == NSNotFound) {
            txtCustTax.text = [NSString stringWithFormat:@"%@ %%", [defaults valueForKey:@"tipitappdatacustomtaxAAfahgq324657ixfghae"]];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [options count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [options objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *tmper = [options objectAtIndex:row];
    txtCustTax.text = [tmper substringToIndex:[tmper length]-5];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:tmper forKey:@"tipitappdatacustomtax"];
    sumit = YES;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 50)];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:31];
    label.text = [NSString stringWithFormat:@"%@", [options objectAtIndex:row]];
    return label;
}

- (IBAction)doneBtn:(id)sender {
    [txtCustTax resignFirstResponder];
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![txtCustTip.text isEqualToString:@""]) {///custom tip actions
        cstmTip = YES;
        customTip = txtCustTip.text;
    }
    else if ([txtCustTip.text isEqualToString:@""]) {
        cstmTip = NO;
        customTip = @"";
    }
    if (![txtBillSplit.text isEqualToString:@""]) {///custom split actions
        billSplit = YES;
        billSplitNum = txtBillSplit.text;
    }
    else if ([txtBillSplit.text isEqualToString:@"1"]) {
        billSplit = NO;
        billSplitNum = @"";
    }
    else if ([txtBillSplit.text isEqualToString:@""]) {
        billSplit = NO;
        billSplitNum = @"";
    }
    if (![txtCustTax.text isEqualToString:@""]) {///custom tax actions
        cstmTax = YES;
        customTax = txtCustTax.text;
        [defaults setValue:customTax forKey:@"tipitappdatacustomtaxAAfahgq324657ixfghae"];
    }
    else if ([txtCustTax.text isEqualToString:@""]) {
        cstmTax = NO;
        [defaults setValue:@"6" forKey:@"tipitappdatacustomtaxAAfahgq324657ixfghae"];
    }
    if (switcher.on == NO) {
        cstmTax = NO;
    }
    else if (switcher.on == YES) {
        cstmTax = YES;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)switcher:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UISwitch *onoff = (UISwitch *) sender;
    if (onoff.on == YES) {
        [defaults setValue:@"ON" forKey:@"tipitappdataswitchstateAAfahgq324657ixfghae"];
        [self cellAlphaState:1 animated:YES];
        cstmTax = YES;
        [defaults setValue:@"6" forKey:@"tipitappdatacustomtaxAAfahgq324657ixfghae"];
        customTax = @"6";
        sumit = YES;
    }
    else if (onoff.on == NO) {
        [defaults setValue:@"OFF" forKey:@"tipitappdataswitchstateAAfahgq324657ixfghae"];
        [self cellAlphaState:0 animated:YES];
        cstmTax = NO;
        [defaults setValue:@"6" forKey:@"tipitappdatacustomtaxAAfahgq324657ixfghae"];
        sumit = YES;
    }
}

- (IBAction)sliderBill:(id)sender {
    UISlider *slider = (UISlider *)sender;
    double val = slider.value;
    if (val < 2){
        txtBillSplit.text = @"";
        slider.value = 0;
    }
    else {
    int intval = val;
    switch (intval) {
        case 2:
            slider.value = 2;
            break;
        case 3:
            slider.value = 3;
            break;
        case 4:
            slider.value = 4;
            break;
        case 5:
            slider.value = 5;
            break;
        case 6:
            slider.value = 6;
            break;
        case 7:
            slider.value = 7;
            break;
        case 8:
            slider.value = 8;
            break;
        case 9:
            slider.value = 9;
            break;
        case 10:
            slider.value = 10;
            break;
    }
    txtBillSplit.text = [NSString stringWithFormat:@"%.f",val];
    billSplitNum = txtBillSplit.text;
    }
}

- (IBAction)DidEndEditBill:(id)sender {
    if ([txtBillSplit.text isEqualToString:@"1"]) {
        txtBillSplit.text = @"";
    }
}

- (IBAction)infoTax:(id)sender {
    UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Tip Before Tax"
                                                message:@"This option calculates the tip before sales tax is involved. The tax is then added to the total after the tip is decided. This reduces the overall amount of gratuity." delegate:self
                                      cancelButtonTitle:@"Done" otherButtonTitles: nil];
    [mes show];
}

- (IBAction)didEndEditTip:(id)sender {
    UITextField *textfield = sender;
    if (![textfield.text isEqualToString:@""]) {
        textfield.text = [NSString stringWithFormat:@"%@ %%",textfield.text];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.text = @"";
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)cellAlphaState:(double)dd animated:(BOOL)anim {
    if (anim == YES) {
        [UIView animateWithDuration:0.2 animations:^() {
            cellone.alpha = dd;
            celltwo.alpha = dd;
            cellthree.alpha = dd;
        }];
    }
    else if (anim == NO) {
        cellone.alpha = dd;
        celltwo.alpha = dd;
        cellthree.alpha = dd;
    }
}

@end
