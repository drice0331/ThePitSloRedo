//
//  TwitterController.h
//  thePitApp
//
//  Created by David Rice on 4/9/14.
//  Copyright (c) 2014 David Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *twitterwebview;
@property (nonatomic,retain) UIActivityIndicatorView *activityIndicatorObject;
@property (strong, nonatomic) IBOutlet UIToolbar *browserBar;
@end
