//
//  YoutubeDetailController.m
//  thePitApp
//
//  Created by David Rice on 1/11/14.
//  Copyright (c) 2014 David Rice. All rights reserved.
//

#import "YoutubeDetailController.h"

@interface YoutubeDetailController ()

@end

@implementation YoutubeDetailController

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
    NSLog(@"%@", self.url);
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //get screen and nav bar bounds for spacing
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenHeight = screenSize.height;
    CGFloat screenWidth = screenSize.width;
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat videoHeightOffset = (screenHeight - 280 - navigationBarHeight)/2;
    
    CGFloat x = screenWidth * 0.1;
    CGFloat y = (screenHeight-navigationBarHeight)*0.12;
    CGFloat width = screenWidth * 0.8;
    CGFloat height = (screenHeight-navigationBarHeight) * 0.7;
    
    NSLog(@"screen height - %f , nav bar height - %f , videoHeightOffset - %f", screenHeight, navigationBarHeight, videoHeightOffset);
    
    NSString *videoURL = self.url;
    NSString *videoHTML = [NSString stringWithFormat:@"\
                           <html><body>\
                           <embed src=\"%@\" type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"%f\" height=\"%f\">\
                           </embed>\
                           </body></html>", videoURL, width, height];
    
    
    CGRect videoFrame = CGRectMake(x, y, width, height);
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame: videoFrame];
    
    webView.opaque = NO;
    webView.backgroundColor = [UIColor blackColor];
    
    
    [webView loadHTMLString: videoHTML baseURL: nil];
    [self.view addSubview: webView];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Share"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(shareDocument:)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    
}

-(IBAction)shareDocument: (id)sender
{
    NSArray* dataToShare = [[NSArray alloc] initWithObjects:self.shareurl, nil];  //data to share
    
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

@end
