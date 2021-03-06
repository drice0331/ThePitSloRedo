//
//  LaunchNavigationController.m
//  thePitApp
//
//  Created by David Rice on 1/7/14.
//  Copyright (c) 2014 David Rice. All rights reserved.
//

#import "LaunchNavigationController.h"
#import "APIKeyAndConstants.h"

@interface LaunchNavigationController ()

@end

@implementation LaunchNavigationController

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
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self checkForWifi];
    
    [self setupButtonPlacement];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];   //it hides
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];    // it shows
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkForWifi
{
    
    Reachability *wifiReachability = [Reachability reachabilityForLocalWiFi];
    Reachability *internetReachability = [Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus statusWifi = [wifiReachability currentReachabilityStatus];
    NetworkStatus statusInternet = [internetReachability currentReachabilityStatus];
    if(statusWifi != ReachableViaWiFi)
    {
        
        if(statusInternet != ReachableViaWWAN)
        {
            UIAlertView *noConnectionAlert = [[UIAlertView alloc] initWithTitle:@"No Connection" message:@"Please check connection to use all features of the app" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil , nil];
            [noConnectionAlert show];
        }
        else
        {
            UIAlertView *wifiAlert = [[UIAlertView alloc] initWithTitle:@"No Wifi Connection" message:@"Connect to wifi to prevent higher charges" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil , nil];
            [wifiAlert show];
        }

    }
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 1)
    {
        NSLog(@"alertview did dismiss");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs://"]];
    }
}

//for different button placement between 3.5 inch and 4 inch
- (void)setupButtonPlacement
{
    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat screenHeight = iOSDeviceScreenSize.height;
    CGFloat screenWidth = iOSDeviceScreenSize.width;
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    
    //Side length
    CGFloat top4ButtonHeightWidth = screenWidth * mainNavTop4ButtonHeightAndWidthFactor;
    CGFloat bottom3ButtonHeightWidth = screenWidth * mainNavBottm3ButtonHeightAndWidthFactor;
    
    //Mid Space
    CGFloat allButtonWidthGap = top4ButtonHeightWidth * mainNavAllButtonWidthGapFactor;
    CGFloat top4ButtonHeightGap = top4ButtonHeightWidth * mainNavTop4ButtonHeightGapFactor;
    CGFloat bottom3Top4HeightGap = screenHeight * mainNavBottom3Top4HeightGapFactor;

    //Y all buttons
    CGFloat blogAndBeltButtonY = screenHeight * mainNavBlogAndBeltButtonYFactor;
    CGFloat contactAndScheduleButtonY = blogAndBeltButtonY + top4ButtonHeightWidth + top4ButtonHeightGap;
    CGFloat bottom3ButtonY = contactAndScheduleButtonY + top4ButtonHeightWidth + bottom3Top4HeightGap;
    
    //X of all buttons
    CGFloat allLeftButtonX = screenWidth * mainNavAllLeftButtonXFactor;
    CGFloat top4RightButtonX = allLeftButtonX + top4ButtonHeightWidth + allButtonWidthGap;
    CGFloat twitterButtonX = allLeftButtonX + bottom3ButtonHeightWidth + allButtonWidthGap;
    CGFloat youtubeButtonX = twitterButtonX + (bottom3ButtonHeightWidth - 1) + allButtonWidthGap; //Minus 1 - twitter button 1 less in h and w
    
    _blogButton.frame = CGRectMake(allLeftButtonX, blogAndBeltButtonY, top4ButtonHeightWidth, top4ButtonHeightWidth);
    _beltButton.frame = CGRectMake(top4RightButtonX, blogAndBeltButtonY, top4ButtonHeightWidth, top4ButtonHeightWidth);
    _contactButton.frame = CGRectMake(allLeftButtonX, contactAndScheduleButtonY, top4ButtonHeightWidth, top4ButtonHeightWidth);
    _scheduleButton.frame = CGRectMake(top4RightButtonX, contactAndScheduleButtonY, top4ButtonHeightWidth, top4ButtonHeightWidth);
    _fbButton.frame = CGRectMake(allLeftButtonX, bottom3ButtonY, bottom3ButtonHeightWidth, bottom3ButtonHeightWidth);
    _twitterButton.frame = CGRectMake(twitterButtonX, bottom3ButtonY, bottom3ButtonHeightWidth - 1, bottom3ButtonHeightWidth - 1);
    _youtubeButton.frame = CGRectMake(youtubeButtonX, bottom3ButtonY, bottom3ButtonHeightWidth, bottom3ButtonHeightWidth);
}

@end
