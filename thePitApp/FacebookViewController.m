//
//  FacebookViewController.m
//  thePitApp
//
//  Created by David Rice on 10/29/13.
//  Copyright (c) 2013 David Rice. All rights reserved.
//

#import "FacebookViewController.h"

@interface FacebookViewController ()

@end

@implementation FacebookViewController

@synthesize activityIndicatorObject;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _fbwebview = self.fbwebview;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    activityIndicatorObject = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicatorObject.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width)/2 - 15, ([UIScreen mainScreen].bounds.size.height)/2 - 15, 30, 30);
    [self.view addSubview:activityIndicatorObject];
    
    self.fbwebview.delegate = self;
    
    //[_browserBar setHidden:true];
    
    [self loadFacebookWebViewPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadFacebookWebViewPage
{
    // Load facebook data
    NSString *fbUrlAddress = @"https://www.facebook.com/pages/The-Pit-SLO/142224835849113"; // here you put your own group
    //Create a URL object.
    NSURL *fbUrl = [NSURL URLWithString:fbUrlAddress];
   
    NSString *webHTMLfb = [NSString stringWithContentsOfURL:fbUrl encoding:NSUTF8StringEncoding error:NULL];
    NSLog(@"webHTML of facebook: %@", webHTMLfb);
    //URL Requst Object
    NSURLRequest *fbRequestObj = [NSURLRequest requestWithURL:fbUrl];
    //Load the request in the UIWebView.
    [_fbwebview loadRequest:fbRequestObj];
//[self webViewDidStartLoad:_fbwebview];
}


- (void)updateBackButton {
    if ([_fbwebview canGoBack]) {
        if (!self.navigationItem.leftBarButtonItem) {
            [self.navigationItem setHidesBackButton:YES animated:YES];
            
            
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backWasClicked:)];
            [self.navigationItem setLeftBarButtonItem:backItem animated:YES];
        }
    }
    else {
        [self.navigationItem setLeftBarButtonItem:nil animated:YES];
        [self.navigationItem setHidesBackButton:NO animated:YES];
    }
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"failed loading");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Can't connect. Please check your Internet connection"
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
    [activityIndicatorObject stopAnimating];
}

- (void)backWasClicked:(id)sender {
    if ([_fbwebview canGoBack]) {
        [_fbwebview goBack];
    }
}


- (IBAction)startAnimating:(id)sender

{
    [activityIndicatorObject startAnimating];
}

- (IBAction)stopAnimating:(id)sender

{
    [activityIndicatorObject stopAnimating];
}

@end
