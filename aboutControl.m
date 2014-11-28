//
//  aboutControl.m...XXX
//  tipCalc
//
//  Created by Arnaud Crowther on 12/9/13.
//  Copyright (c) 2013 Arnaud Crowther. All rights reserved.
//

#import "aboutControl.h"
#import "UIView+Glow.h"
#import "settingTable.h"

@interface aboutControl ()

@end

@implementation aboutControl

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:(0/255.0) green:(128/255.0) blue:(0/255.0) alpha:1]];
}

- (void)viewWillAppear:(BOOL)animated {
    btnCounter = 0;
}

- (void)viewWillDisappear:(BOOL)animated {
    [tipcatimg stopGlowing];
    [self.navigationController.navigationBar stopGlowing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)tipCat:(id)sender {
    [self.navigationController.navigationBar setTintColor:[self randomColor]];
    [UIView animateWithDuration:0.1 animations:^() {
        viewX.backgroundColor = [self randomColor];
        [self.navigationController.navigationBar startGlowingWithColor:[self randomColor] intensity:.3];
    }];
    [tipcatimg startGlowingWithColor:[self randomColor] intensity:.5];
    btnCounter ++;
    switch (btnCounter) {
        case 10:
            [self customAlertWithMessage:
             @"Meow?" Title:@" " Button:@"..."];
            break;
        case 30:
            [self customAlertWithMessage:
             @"what are you still doing here?" Title:@"O_o" Button:@"I'm not sure"];
            break;
        case 50:
            [self customAlertWithMessage:
             @"Last message, quit while you're ahead." Title:@"Error" Button:@"OK"];
            break;
        case 80:
            [self customAlertWithMessage:
             @"Proceeding further may have undocumented effects..." Title:@"STOP!" Button:@"Done"];
            break;
        case 100:
            [self customAlertWithMessage:
             @"jk." Title:@"WINNER!" Button:@":("];
            break;
        case 1000:
            [self customAlertWithMessage:
             @"I doubt anyone will ever read this." Title:@"1000" Button:@"(^-^)"];
            btnCounter = 0;
            break;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIColor *)randomColor {
    NSInteger r = arc4random()%255;
    NSInteger g = arc4random()%255;
    NSInteger b = arc4random()%255;
    
    return [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:1];
}

- (void)customAlertWithMessage:(NSString *)mess Title:(NSString *)tit Button:(NSString *)btn {
    UIAlertView* mes=[[UIAlertView alloc] initWithTitle:tit
                                                message:mess delegate:self cancelButtonTitle:btn otherButtonTitles: nil];
    [mes show];
}

@end
