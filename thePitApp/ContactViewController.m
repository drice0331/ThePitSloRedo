//
//  ContactViewController.m
//  thePitApp
//
//  Created by David Rice on 11/3/13.
//  Copyright (c) 2013 David Rice. All rights reserved.
//

#import "ContactViewController.h"
#import "APIKeyAndConstants.h"

@interface ContactViewController ()
{
    double latitude;
    double longitude;
}
@end

@implementation ContactViewController
{
    CLLocationManager *locationManager;
}

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
    self.mapView.delegate = self;
    
    [self setSubviewPlacement];
    
    //pit coordinates
    latitude = 0;
    longitude = 0;
    
    //set label text
    [self.phoneNumber setTitle:contactPhone forState:UIControlStateNormal];
    [self.email setTitle:contactEmail forState:UIControlStateNormal];
    [self.address setTitle:contactAddress forState:UIControlStateNormal];

    self.address.titleLabel.text = @"Address: 1285 Laurel Lane";
    
    //position text in buttons
    self.phoneNumber.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.email.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.address.titleLabel.textAlignment = NSTextAlignmentLeft;
    //
    
    NSString *addressString = [NSString stringWithFormat:contactMapAddress];
    NSString *esc_addr =  [addressString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:contactGoogleMapString, esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D destination;
    destination.latitude = latitude;
    destination.longitude = longitude;
    
    MKCoordinateSpan theSpan = MKCoordinateSpanMake(0.003, 0.003);
    MKCoordinateRegion region = MKCoordinateRegionMake(destination, theSpan);
    
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
    
    MKPointAnnotation *newAnnotation = [[MKPointAnnotation alloc] init];
    newAnnotation.coordinate = destination;
    newAnnotation.title = @"The Pit";
    newAnnotation.subtitle = contactAddress;
    [_mapView addAnnotation:newAnnotation];
    [_mapView setRegion: adjustedRegion animated: NO];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)callThePit:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:contactPhoneUrl]];
}

- (IBAction)emailThePit:(id)sender
{
    
    if(MFMailComposeViewController.canSendMail)
    {
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc]init];
        controller.mailComposeDelegate = self;
        NSArray *recipients = [[NSArray alloc]initWithObjects:contactEmail, nil];
        [controller setToRecipients:recipients];
        [self presentViewController:controller animated:YES completion:nil];
        //check later, if doesn't work, do the ghetto mailto way
    }
    else
    {
        NSLog(@"cannot send email");
        //put a pop up dialog in here
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self becomeFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)gpsToThePit:(id)sender
{

    CLLocationCoordinate2D destination;
    destination.latitude = latitude;
    destination.longitude = longitude;
    
    //current location coordinates
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    
    MKUserLocation *currentLoc;
    CLLocation *loc = currentLoc.location;
    
    NSLog(@"Current loc - latitude %g longitude %g", loc.coordinate.latitude, loc.coordinate.longitude);
    NSLog(@"Dest loc - latitude %g longitude %g", destination.latitude, destination.longitude);
    
    /*
    if(nil == loc)
    {
        NSLog(@"cur loc is nil");
        return;
    }
     */
        Class itemClass = [MKMapItem class];
        if (itemClass && [itemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])//can open with map app
        {
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:destination addressDictionary:nil] ];
            toLocation.name = @"Destination";
            [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
                           launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil]
                                                                     forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
        }
        else //google maps online
        {
            NSMutableString *mapURL = [NSMutableString stringWithString:@"http://maps.google.com/maps?"];
            [mapURL appendFormat:@"saddr=Current Location"];
            [mapURL appendFormat:@"&daddr=%f,%f", destination.latitude, destination.longitude];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[mapURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        }
}

- (void)setSubviewPlacement
{
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    CGFloat allLabelX = screenWidth * contactAllLabelsXRatio;
    CGFloat allLabelWidth = screenWidth * contactAllLabelsWidthRatio;
    
    CGFloat allButtonX = screenWidth * contactAllButtonsXRatio;
    CGFloat allButtonWidth = screenWidth * contactAllButtonsWidthRatio;
    CGFloat allLabelButtonHeight = screenHeight * contactAllLabelsAndButtonsHeightFactor;
    CGFloat allLabelButtonHeightGap = screenHeight * contactAllLabelsAndButtonsHeightGapFactor;
    
    CGFloat callLabelButtonY = screenHeight * contactCallLabelAndButtonYFactor;
    
    CGFloat mapViewX = screenWidth * contactMapViewYFactor;
    CGFloat mapViewWidth = screenWidth * contactMapViewXFactor;
    CGFloat mapViewY = screenHeight * contactMapViewHeightFactor;
    CGFloat mapViewHeight = screenHeight * contactMapViewWidthFactor;
    
    
    self.phoneLabel.frame = CGRectMake(allLabelX, callLabelButtonY, allLabelWidth, allLabelButtonHeight);
    self.phoneNumber.frame = CGRectMake(allButtonX, callLabelButtonY, allButtonWidth, allLabelButtonHeight);
    self.emailLabel.frame = CGRectMake(allLabelX, callLabelButtonY + allLabelButtonHeightGap, allLabelWidth, allLabelButtonHeight);
    self.email.frame = CGRectMake(allButtonX, callLabelButtonY + allLabelButtonHeightGap, allButtonWidth, allLabelButtonHeight);
    self.addressLabel.frame = CGRectMake(allLabelX, callLabelButtonY + (allLabelButtonHeightGap *2), allLabelWidth, allLabelButtonHeight);
    self.address.frame = CGRectMake(allButtonX, callLabelButtonY + (allLabelButtonHeightGap*2), allButtonWidth, allLabelButtonHeight);
    self.mapView.frame = CGRectMake(mapViewX, mapViewY,mapViewWidth, mapViewHeight);

}

@end
