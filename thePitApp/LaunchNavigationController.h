//
//  LaunchNavigationController.h
//  thePitApp
//
//  Created by David Rice on 1/7/14.
//  Copyright (c) 2014 David Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface LaunchNavigationController : UIViewController <UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *blogButton;
@property (strong, nonatomic) IBOutlet UIButton *beltButton;
@property (strong, nonatomic) IBOutlet UIButton *contactButton;
@property (strong, nonatomic) IBOutlet UIButton *scheduleButton;
@property (strong, nonatomic) IBOutlet UIButton *fbButton;
@property (strong, nonatomic) IBOutlet UIButton *twitterButton;
@property (strong, nonatomic) IBOutlet UIButton *youtubeButton;

@end
