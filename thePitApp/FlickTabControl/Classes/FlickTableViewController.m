//
//  FlickTableViewController.m
//  FlickTabControl
//
//  Created by Shaun Harrison on 2/10/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "FlickTableViewController.h"

@implementation FlickTableViewController
@synthesize tableView=_tableView, flickTabView=_flickTabView;

- (void)loadView {
	[super loadView];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
    //tableview frame
	UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
	self.tableView = tableView;
	
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	
	[self.view addSubview:self.tableView];
	
    //flick tab view frame
	FlickTabView* aFlickTabView = [[FlickTabView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 43.0f)];
	self.flickTabView = aFlickTabView;
	
	self.flickTabView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
	self.flickTabView.delegate = self;
	self.flickTabView.dataSource = self;
	
    //scrollview frame part of flicktabview
	self.flickTabView.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.flickTabView.frame.size.width, self.flickTabView.frame.size.height)];
    //other scrollview part of flicktabview properties
	self.flickTabView.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	self.flickTabView.scrollView.directionalLockEnabled = YES;
	self.flickTabView.scrollView.alwaysBounceVertical = NO;
	self.flickTabView.scrollView.alwaysBounceHorizontal = YES;
	self.flickTabView.scrollView.showsVerticalScrollIndicator = NO;
	self.flickTabView.scrollView.showsHorizontalScrollIndicator = NO;
	self.flickTabView.scrollView.bounces = YES;
	self.flickTabView.scrollView.contentInset = UIEdgeInsetsMake(0.0f, 20.0f, 0.0f, 20.0f);
	self.flickTabView.scrollView.delegate = self.flickTabView;
	
    //self.flickTabView.scrollView.backgroundColor = [UIColor blackColor];
	self.flickTabView.backgroundColor = [UIColor blackColor];
	
    //setting background of flicktabview (setting it to stretch over it by setting frame to be its width and height)
	UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.flickTabView.frame.size.width, self.flickTabView.frame.size.height)];
	imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	
	[self.flickTabView addSubview:imageView];
	
	[self.flickTabView addSubview:self.flickTabView.scrollView];
	
    //Left Cap set up
    /*
	UIImageView* leftCap = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 39.0f, 43.0f)];
	leftCap.image = [UIImage imageNamed:@"flick-fade-lt.png"];
	leftCap.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
	self.flickTabView.leftCap = leftCap;
     */
	
    //Right cap set up
    /*
	UIImageView* rightCap = [[UIImageView alloc] initWithFrame:CGRectMake(self.flickTabView.frame.size.width-39.0f, 0.0f, 39.0f, 43.0f)];
	rightCap.image = [UIImage imageNamed:@"flick-fade-rt.png"];
	rightCap.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
	self.flickTabView.rightCap = rightCap;
	*/
    //adding cap to subviews
    /*
	[self.flickTabView addSubview:self.flickTabView.leftCap];
	[self.flickTabView addSubview:self.flickTabView.rightCap];
	*/
	[self.flickTabView awakeFromNib];
	
    //header - first row of table view
	self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 1.0f, 43.0f)];
	
	[self.view addSubview:self.flickTabView];
}

//when scrolling tableview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if(scrollView == self.tableView) {
		float y = (-scrollView.contentOffset.y);
		float height = y > 0.0f ? 43.0f + y : 43.0f;
		y = y > 0.0f ? 0.0f : y;
        
        //changing position of flicktabview as tableview scrollview changes
		self.flickTabView.frame = CGRectMake(0.0f, y, self.tableView.frame.size.width, height);
		
        //Makes sure that vertical scrollview indicator is properly alligned when flicktabview gets offscreen/onscreen
		float inset = 0.0f;
		if(scrollView.contentOffset.y < 44.0f) {
            inset = 44.0f + -scrollView.contentOffset.y;
		}
		
		self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(inset, 0.0f, 0.0f, 0.0f);
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set up the cell...
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollTabView:(FlickTabView*)scrollTabView didSelectedTabAtIndex:(NSInteger)index {
	// Subclass
}

- (NSInteger)numberOfTabsInScrollTabView:(FlickTabView*)scrollTabView {
	return 0;
}

- (NSString*)scrollTabView:(FlickTabView*)scrollTabView titleForTabAtIndex:(NSInteger)index {
	return nil;
}




@end

