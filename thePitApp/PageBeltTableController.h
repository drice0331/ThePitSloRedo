//
//  PageBeltTableController.h
//  thePitApp
//
//  Created by David Rice on 4/16/14.
//  Copyright (c) 2014 David Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface PageBeltTableController : UITableViewController <NSXMLParserDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSString *beltType;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSUInteger pageIndex;

@end
