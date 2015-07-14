//
//  PageContainerViewController.h
//  thePitApp
//
//  Created by David Rice on 4/16/14.
//  Copyright (c) 2014 David Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContainerViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) UITableViewController *beltTableController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageTables;
@end
