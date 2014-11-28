//
//  ViewController.h
//  tipCalc
//
//  Created by Arnaud Crowther on 12/4/13.
//  Copyright (c) 2013 Arnaud Crowther. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController
{
    AVAudioPlayer *audioPlayer;
    NSTimer *aTimer;
    NSString *numberString;
    double tipValue;
    BOOL complete;
    
    IBOutlet UILabel *labelTip;
    IBOutlet UILabel *labelMain;
    IBOutlet UISlider *sliderTip;
    IBOutlet UILabel *labelBeftax;
    
    
    IBOutlet UIButton *btnO1;
    IBOutlet UIButton *btnO2;
    IBOutlet UIButton *btnO3;
    IBOutlet UIButton *btnO4;
    IBOutlet UIButton *btnO5;
    IBOutlet UIButton *btnO6;
    IBOutlet UIButton *btnO7;
    IBOutlet UIButton *btnO8;
    IBOutlet UIButton *btnO9;
    IBOutlet UIButton *btnO0;
    IBOutlet UIButton *btnOdec;
    
    IBOutlet UIView *colorView;
}
- (IBAction)sliderTipIBA:(id)sender;

- (IBAction)btnN1:(id)sender;
- (IBAction)btnN2:(id)sender;
- (IBAction)btnN3:(id)sender;
- (IBAction)btnN4:(id)sender;
- (IBAction)btnN5:(id)sender;
- (IBAction)btnN6:(id)sender;
- (IBAction)btnN7:(id)sender;
- (IBAction)btnN8:(id)sender;
- (IBAction)btnN9:(id)sender;
- (IBAction)btnN0:(id)sender;
- (IBAction)btnNdec:(id)sender;
- (IBAction)btnNsum:(id)sender;

- (IBAction)btnClear:(id)sender ;




@end
