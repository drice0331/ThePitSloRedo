//
//  BlogDetailViewController.m
//  thePitApp
//
//  Created by David Rice on 12/18/13.
//  Copyright (c) 2013 David Rice. All rights reserved.
//

#import "BlogDetailViewController.h"

@interface BlogDetailViewController ()

@end

@implementation BlogDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Managing the detail item

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *myURL = [NSURL URLWithString: [self.url stringByAddingPercentEscapesUsingEncoding:
                                          NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    [self.webView loadRequest:request];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Share"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(shareDocument:)];
    self.navigationItem.rightBarButtonItem = shareButton;
}

-(IBAction)shareDocument: (id)sender
{
    NSArray* dataToShare = [[NSArray alloc] initWithObjects:self.url, nil];  //data to share
    
    UIActivityViewController* activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:dataToShare
                                      applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
}

@end
