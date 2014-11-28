//
//  aboutControl.h
//  tipCalc
//
//  Created by Arnaud Crowther on 12/9/13.
//  Copyright (c) 2013 Arnaud Crowther. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aboutControl : UIViewController
{
    IBOutlet UIView *viewX;
    IBOutlet UIImageView *tipcatimg;
    IBOutlet UIButton *siteBtn;
    int btnCounter;
}

- (IBAction)tipCat:(id)sender;



@end
