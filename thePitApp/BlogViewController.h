//
//  BlogViewController.h
//  thePitApp
//
//  Created by David Rice on 10/24/13.
//  Copyright (c) 2013 David Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@protocol BlogViewControllerDelegate;

@interface BlogViewController : UITableViewController <NSXMLParserDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *blogPostTable;



@end
