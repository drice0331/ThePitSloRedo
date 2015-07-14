//
//  BeltProgressTableController.h
//  thePitApp
//
//  Created by David Rice on 1/26/14.
//  Copyright (c) 2014 David Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeltProgressTableController : UITableViewController <NSXMLParserDelegate>

@property (strong, nonatomic) NSString *beltType;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
