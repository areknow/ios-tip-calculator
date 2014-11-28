//
//  ViewController.m
//  tipCalc
//
//  Created by Arnaud Crowther on 12/4/13.
//  Copyright (c) 2013 Arnaud Crowther. All rights reserved.
//

#import "ViewController.h"
#import "settingTable.h"
#import "UIView+Glow.h"

@interface ViewController ()

@end

@implementation ViewController {
    float btnF1;
    float btnF2;
    float btnF3;
    float btnF4;
    float btnF5;
    float btnF6;
    float btnF7;
    float btnF8;
    float btnF9;
    float btnF0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(enterBGmode)
                                                 name: UIApplicationDidEnterBackgroundNotification
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(enterACTIVEmode)
                                                 name: UIApplicationDidEnterBackgroundNotification
                                               object: nil];
    [self enterACTIVEmode];

    numberString = @"0.00";
    tipValue = sliderTip.value;
    complete = YES;
    
    [sliderTip setThumbImage:[UIImage imageNamed:@"thuminsh.png"] forState:UIControlStateNormal];
    [sliderTip setMinimumTrackImage:[UIImage alloc] forState:UIControlStateNormal];
    [sliderTip setMaximumTrackImage:[UIImage alloc] forState:UIControlStateNormal];
    
    UIColor *newColor = [UIColor colorWithRed:0/255 green:255/255 blue:0/255 alpha:1];
    [colorView setBackgroundColor:newColor];
    self.view.backgroundColor = [UIColor redColor];
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Pop.aiff", [[NSBundle mainBundle] resourcePath]]];
	NSError *error;
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = 1;
    
    customTax = [defaults valueForKey:@"tipitappdatacustomtaxAAfahgq324657ixfghae"];
    if (![defaults valueForKey:@"tipitappdataswitchstateAAfahgq324657ixfghae"]) {
        cstmTax = NO;
    }
    if ([[defaults valueForKey:@"tipitappdataswitchstateAAfahgq324657ixfghae"] isEqualToString:@"ON"]) {
        cstmTax = YES;
    }
    else if (![[defaults valueForKey:@"tipitappdataswitchstateAAfahgq324657ixfghae"] isEqualToString:@"OFF"]) {
        cstmTax = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    if (cstmTip == YES) {
        tipValue = [customTip doubleValue];
        sliderTip.value = [customTip doubleValue];
        labelTip.text = [NSString stringWithFormat:@"%.f%%",[customTip doubleValue]];
        UIColor *newColor = [[UIColor alloc] init];
        if ([customTip doubleValue] >= 50) {
            newColor = [UIColor blueColor];
            [colorView setBackgroundColor:newColor];
            [self colorviewPulseAnimated:YES];
        }
        else if ([customTip doubleValue] < 50) {
            double alphaVal = [customTip doubleValue] /25;
            newColor = [UIColor colorWithRed:0/255 green:255/255 blue:0/255 alpha:alphaVal];
            [colorView setBackgroundColor:newColor];
            [self colorviewPulseAnimated:NO];
        }
        if (cstmTax == NO) {
            [self mathsWithSplit:NO Tax:NO];
        }
        if (cstmTax == YES) {
            [self mathsWithSplit:NO Tax:YES];
        }
        if ([numberString isEqualToString:@"0.00"]) {
            labelMain.text = @"Enter Bill Amount";
        }
    }
    else if (cstmTip == NO) {
        sliderTip.value = tipValue;
        labelTip.text = [NSString stringWithFormat:@"%.f%%",tipValue];
    }
    if (![numberString isEqualToString:@"0.00"]) {
        if (billSplit == YES) {
            if (cstmTax == NO) {
                [self mathsWithSplit:YES Tax:NO];
            }
            if (cstmTax == YES) {
                [self mathsWithSplit:YES Tax:YES];
            }
        }
    }
    if (sumit == YES) {
        [self btnNsum:self];
    }
    if (cstmTax == YES) {
        [labelBeftax setHidden:NO];
    }
    if (cstmTax == NO) {
        [labelBeftax setHidden:YES];
    }
}

#pragma mark - SLIDER

- (IBAction)sliderTipIBA:(id)sender {
    if (complete == NO) {
        complete = YES;
    }
    UISlider *slider = (UISlider *)sender;
    double val = slider.value;
    tipValue = val;
    double alphaVal = val / 25;
    labelTip.text = [NSString stringWithFormat:@"%.f%%",tipValue];
    UIColor *newColor = [UIColor colorWithRed:0/255 green:255/255 blue:0/255 alpha:alphaVal];
    if (val >= 50) {
        newColor = [UIColor blueColor];
        [self colorviewPulseAnimated: YES];
    }
    else if (val < 50) {
        [self colorviewPulseAnimated:NO];
    }
    [colorView setBackgroundColor:newColor];
    if (![numberString isEqualToString:@"0.00"]) {
        if (cstmTax == NO) {
            [self mathsWithSplit:NO Tax:NO];
        }
        if (cstmTax == YES) {
            [self mathsWithSplit:NO Tax:YES];
        }
    }
    cstmTip = NO;
}

#pragma mark - BUTTONS

- (IBAction)btnNsum:(id)sender {//"="
    if (cstmTax == NO) {
        [self mathsWithSplit:NO Tax:NO];
    }
    if (cstmTax == YES) {
        [self mathsWithSplit:NO Tax:YES];
    }
    if ([numberString isEqualToString:@"0.00"]) {
        labelMain.text = @"Enter Bill Amount";
    }
    [audioPlayer play];
}

- (IBAction)btnNdec:(id)sender {//"."
    [audioPlayer play];
    [self isComplete];
    if ([numberString  isEqualToString: @""]) {
        numberString = @"0";
    }
    NSRange range = [numberString rangeOfString:@"."];
    if (range.location == NSNotFound) {
        labelMain.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:54];
        numberString = [NSString stringWithFormat:@"%@.",numberString];
        labelMain.text = [NSString stringWithFormat:@"%@",numberString];
    }
}

- (IBAction)btnClear:(id)sender {//"C"
    AudioServicesPlaySystemSound(0x450);
    numberString = @"0.00";
    labelMain.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:35];
    labelMain.text = @"Enter Bill Amount";
    complete = YES;
    billSplit = NO;
}

- (void)buttonActionWithVal:(float)btnVal labelTextSize:(int)lblSize {
    [audioPlayer play];
    int size = lblSize;
    float btn = btnVal;
    numberString = [NSString stringWithFormat:@"%@%.f",numberString,btn];
    labelMain.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:size];
    labelMain.text = [NSString stringWithFormat:@"%@",numberString];
}

- (void)isComplete {
    if (complete == YES) {
        numberString = @"";
        complete = NO;
    }
}

- (IBAction)btnN1:(id)sender {
    [self isComplete];
    [self buttonActionWithVal:1.0 labelTextSize:54];
}

- (IBAction)btnN2:(id)sender {
    [self isComplete];
    [self buttonActionWithVal:2.0 labelTextSize:54];
}

- (IBAction)btnN3:(id)sender {
    [self isComplete];
    [self buttonActionWithVal:3.0 labelTextSize:54];
}

- (IBAction)btnN4:(id)sender {
    [self isComplete];
    [self buttonActionWithVal:4.0 labelTextSize:54];
}

- (IBAction)btnN5:(id)sender {
    [self isComplete];
    [self buttonActionWithVal:5.0 labelTextSize:54];
}

- (IBAction)btnN6:(id)sender {
    [self isComplete];
    [self buttonActionWithVal:6.0 labelTextSize:54];
}

- (IBAction)btnN7:(id)sender {
    [self isComplete];
    [self buttonActionWithVal:7.0 labelTextSize:54];
}

- (IBAction)btnN8:(id)sender {
    [self isComplete];
    [self buttonActionWithVal:8.0 labelTextSize:54];
}

- (IBAction)btnN9:(id)sender {
    [self isComplete];
    [self buttonActionWithVal:9.0 labelTextSize:54];
}

- (IBAction)btnN0:(id)sender {
    [self isComplete];
    [self buttonActionWithVal:0.0 labelTextSize:54];
}

#pragma mark - CUSTOM

- (void)enterBGmode {
    [aTimer invalidate];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
}

- (void)enterACTIVEmode {
    aTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(counter)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)counter {
    if (complete == YES) {
        [self setButtonsOnOff:YES];
    }
    if (complete == NO) {
        NSRange range = [numberString rangeOfString:@"."];
        if (range.location == NSNotFound) {
        }
        else {
            NSArray *myArray = [numberString componentsSeparatedByString:@"."];
            if (![myArray[1] isEqualToString: @""]) {
                if ([myArray[1] length] == 2 ) {
                    [self setButtonsOnOff:NO];
                }
            }
        }
    }
}

- (void)setButtonsOnOff: (BOOL)x {
    [btnO0 setEnabled:x];
    [btnO1 setEnabled:x];
    [btnO2 setEnabled:x];
    [btnO3 setEnabled:x];
    [btnO4 setEnabled:x];
    [btnO5 setEnabled:x];
    [btnO6 setEnabled:x];
    [btnO7 setEnabled:x];
    [btnO8 setEnabled:x];
    [btnO9 setEnabled:x];
    [btnOdec setEnabled:x];
}

- (void)colorviewPulseAnimated:(BOOL) y {
    if (y==YES) {
        [colorView startGlowing];
    }
    else if (y==NO) {
        [colorView stopGlowing];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)mathsWithSplit:(BOOL)split Tax:(BOOL)tax {
    if (tax == YES) {
        double numberStringNoTax = [numberString doubleValue] - ([numberString doubleValue] * ([customTax doubleValue]/100));
        NSString *numberStringNoTaxStr = [NSString stringWithFormat:@"%.2f",numberStringNoTax];
        double removedTax = ([numberString doubleValue] * ([customTax doubleValue]/100));//has to be added back at end after tip
        if (split == YES) {
            NSString *tipStr = [NSString stringWithFormat:@"%.2f",tipValue / 100];
            double tipPrc;
            tipPrc = [tipStr doubleValue];
            double tipActual = 0;
            tipActual = [numberStringNoTaxStr doubleValue] * tipPrc;
            NSString *tipActStr = [NSString stringWithFormat:@"%.02f",tipActual];
            double blSplt =  ([numberStringNoTaxStr doubleValue] + removedTax) / [billSplitNum doubleValue];
            NSString *billSplitString = [NSString stringWithFormat:@"%.2f",blSplt];
            double tipSpl = [tipActStr doubleValue]/[billSplitNum doubleValue];
            NSString *tipSplitString = [NSString stringWithFormat:@"%.2f",tipSpl];
            labelMain.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:35];
            labelMain.text = [NSString stringWithFormat:
                              @"Split %@ ways\nEach Tip: $%@\nEach Pay: $%@", billSplitNum, tipSplitString, billSplitString];
        }
        if (split == NO) {
            NSString *tipStr = [NSString stringWithFormat:@"%.2f",tipValue / 100];
            double tipPrc = [tipStr doubleValue];
            double tipActual = 0;
            tipActual = [numberStringNoTaxStr doubleValue] * tipPrc;
            NSString *tipActStr = [NSString stringWithFormat:@"%.2f",tipActual];
            double billTotal = [numberStringNoTaxStr doubleValue] + [tipActStr doubleValue] + removedTax;
            NSString *billTtlStr = [NSString stringWithFormat:@"%.2f",billTotal];
            labelMain.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:35];
            complete = YES;
            labelMain.text = [NSString stringWithFormat:
                              @"Bill: $%@\nTip: $%@\nTotal: $%@", numberString, tipActStr, billTtlStr];
        }
    }
    else if (tax == NO) {
        if (split == YES) {
            NSString *tipStr = [NSString stringWithFormat:@"%.2f",tipValue / 100];
            double tipPrc;
            tipPrc = [tipStr doubleValue];
            double tipActual = 0;
            tipActual = [numberString doubleValue] * tipPrc;
            NSString *tipActStr = [NSString stringWithFormat:@"%.02f",tipActual];
            double blSplt =  [numberString doubleValue] / [billSplitNum doubleValue];
            NSString *billSplitString = [NSString stringWithFormat:@"%.2f",blSplt];
            double tipSpl = [tipActStr doubleValue]/[billSplitNum doubleValue];
            NSString *tipSplitString = [NSString stringWithFormat:@"%.2f",tipSpl];
            labelMain.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:35];
            labelMain.text = [NSString stringWithFormat:
                              @"Split %@ ways\nEach Tip: $%@\nEach Pay: $%@", billSplitNum, tipSplitString, billSplitString];
        }
        if (split == NO) {
            NSString *tipStr = [NSString stringWithFormat:@"%.2f",tipValue / 100];
            double tipPrc = [tipStr doubleValue];
            double tipActual = 0;
            tipActual = [numberString doubleValue] * tipPrc;
            NSString *tipActStr = [NSString stringWithFormat:@"%.2f",tipActual];
            double billTotal = [numberString doubleValue] + [tipActStr doubleValue];
            NSString *billTtlStr = [NSString stringWithFormat:@"%.2f",billTotal];
            labelMain.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:35];
            complete = YES;
            labelMain.text = [NSString stringWithFormat:
                              @"Bill: $%@\nTip: $%@\nTotal: $%@", numberString, tipActStr, billTtlStr];
        }
    }
}

@end