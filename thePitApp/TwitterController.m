//
//  TwitterController.m
//  thePitApp
//
//  Created by David Rice on 4/9/14.
//  Copyright (c) 2014 David Rice. All rights reserved.
//

#import "TwitterController.h"

@interface TwitterController ()

@end

@implementation TwitterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     ** activity indicator in center of view
     
    _activityIndicatorObject = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityIndicatorObject.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width)/2 - 15, ([UIScreen mainScreen].bounds.size.height)/2 - 15, 30, 30);
    
    [self.view addSubview:_activityIndicatorObject];
     */

    self.twitterwebview.delegate = self;

    [self loadTwitterWebViewPage];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTwitterWebViewPage
{
    // Load facebook data
    NSString *twitterUrlAddress = @"https://twitter.com/THEPITSLO"; // here you put your own group
    //Create a URL object.
    NSURL *twitterUrl = [NSURL URLWithString:twitterUrlAddress];
    
    
    NSString *webHTMLtwitter = [NSString stringWithContentsOfURL:twitterUrl encoding:NSUTF8StringEncoding error:NULL];
    NSLog(@"webHTML of facebook: %@", webHTMLtwitter);
    //URL Requst Object
    NSURLRequest *twitterRequestObj = [NSURLRequest requestWithURL:twitterUrl];
    //Load the request in the UIWebView.
    [_twitterwebview loadRequest:twitterRequestObj];
    //[self webViewDidStartLoad:_fbwebview];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_activityIndicatorObject startAnimating];
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_activityIndicatorObject stopAnimating];
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
    [_activityIndicatorObject stopAnimating];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
