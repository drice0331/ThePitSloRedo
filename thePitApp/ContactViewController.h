//
//  ContactViewController.h
//  thePitApp
//
//  Created by David Rice on 11/3/13.
//  Copyright (c) 2013 David Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ContactViewController : UIViewController <MFMailComposeViewControllerDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *phoneNumber;
@property (strong, nonatomic) IBOutlet UIButton *email;
@property (strong, nonatomic) IBOutlet UIButton *address;

@end
