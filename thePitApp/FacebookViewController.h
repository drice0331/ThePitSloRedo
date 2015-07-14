//
//  FacebookViewController.h
//  thePitApp
//
//  Created by David Rice on 10/29/13.
//  Copyright (c) 2013 David Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacebookViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *fbwebview;
@property (nonatomic,retain) UIActivityIndicatorView *activityIndicatorObject;
@property (strong, nonatomic) IBOutlet UIToolbar *browserBar;

@end
