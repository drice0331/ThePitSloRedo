//
//  BlogDetailViewController.h
//  thePitApp
//
//  Created by David Rice on 12/18/13.
//  Copyright (c) 2013 David Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlogDetailViewController : UIViewController <UIWebViewDelegate>

@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
