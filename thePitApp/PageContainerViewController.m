//
//  PageContainerViewController.m
//  thePitApp
//
//  Created by David Rice on 4/16/14.
//  Copyright (c) 2014 David Rice. All rights reserved.
//

#import "PageContainerViewController.h"
#import "PageBeltTableController.h"

@interface PageContainerViewController ()
{
    NSArray *viewControllers;
    NSString *beltTable;
    NSUInteger pageIndex;
    BOOL transitionComplete;
    int indexForTitle;
}
@end

@implementation PageContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Create the data model
    _pageTables = @[@"Kempo Adults", @"Kempo Kids", @"Jiu Jitsu"];
    
    //title index variable initialize
    transitionComplete = false;
    indexForTitle = 0;
    self.navigationItem.title = @"Kempo Adults";
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    PageBeltTableController *startingViewController = [self viewControllerAtIndex:0];
    /*
    startingViewController.beltType = @"Kempo Adults";
    PageBeltTableController *secondViewController = [self viewControllerAtIndex:1];
    startingViewController.beltType = @"Kempo Kids";
    PageBeltTableController *thirdViewController = [self viewControllerAtIndex:2];
    startingViewController.beltType = @"Jiu Jitsu";
*/
    viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}
/*
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if(pageIndex == 0)
    {
        self.navigationItem.title = @"Kempo Adults";
    }
    else if(pageIndex == 1) {
        self.navigationItem.title = @"Kempo Kids";
    }
    else if(pageIndex == 2) {
        self.navigationItem.title = @"Jiu Jitsu";
    }
    
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    //NSLog(@"in viewControllerAtIndex - index at index %lu", (unsigned long)index);
    if (([self.pageTables count] == 0) || (index >= [self.pageTables count])) {
        return nil;
        NSLog(@"pagetables.count = 0");
    }
    //return [viewControllers objectAtIndex:index];
    
    //UIViewController *pageContentViewController;
    
    // Create a new view controller and pass suitable data.
    
    PageBeltTableController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageBeltTableController"];;
    pageContentViewController.pageIndex = index;
    if(index == 0)
    {
        //self.navigationItem.title = @"Kempo Adults";
        pageContentViewController.beltType = @"Kempo Adults";
        pageIndex = 0;
        
    }
    else if(index == 1){
        //self.navigationItem.title = @"Kempo Kids";
        pageContentViewController.beltType = @"Kempo Kids";
        pageIndex = 1;
        
    }
    else if(index == 2){
        //self.navigationItem.title = @"Jiu Jitsu";
        pageContentViewController.beltType = @"Jiu Jitsu";
        pageIndex = 2;
    }
    pageContentViewController.pageIndex = index;

    
    return pageContentViewController;
     
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    if(transitionComplete)
    {
        NSLog(@"Before trans complete - index %ld", (long)indexForTitle);
        indexForTitle--;
        if(indexForTitle == 0)
        {
            self.navigationItem.title = @"Kempo Adults";
        }
        else if(indexForTitle == 1)
        {
            self.navigationItem.title = @"Kempo Kids";
        }
        else if(indexForTitle == 2)
        {
            self.navigationItem.title = @"Jiu Jitsu";
        }
        transitionComplete = false;
    }
    
    NSUInteger index = ((PageBeltTableController *) viewController).pageIndex;

    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    NSLog(@"BEFOREviewconroller index = %ld to %ld", (long)(index+1), (long)index);

    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if(transitionComplete)
    {
        NSLog(@"After trans complete - index %ld", (long)indexForTitle);
        indexForTitle++;
        if(indexForTitle == 0)
        {
            self.navigationItem.title = @"Kempo Adults";
        }
        else if(indexForTitle == 1)
        {
            self.navigationItem.title = @"Kempo Kids";
        }
        else if(indexForTitle == 2)
        {
            self.navigationItem.title = @"Jiu Jitsu";
        }
        transitionComplete = false;
    }
    NSUInteger index = ((PageBeltTableController *) viewController).pageIndex;

    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    NSLog(@"AFTERviewconroller index = %ld to %ld", (long)(index-1), (long)index);

    if (index == [self.pageTables count]) {
        return nil;
    }
    

    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTables count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed)
    {
        NSLog(@"transComplete");
        transitionComplete = true;
    }
}

@end
