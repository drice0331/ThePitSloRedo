//
//  BlogViewController.m
//  thePitApp
//
//  Created by David Rice on 10/24/13.
//  Copyright (c) 2013 David Rice. All rights reserved.
//

#import "BlogViewController.h"
#import "BlogDetailViewController.h"
#import "APIKeyAndConstants.h"

@interface BlogViewController (){
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSString *element;
}

@end



@implementation BlogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.separatorColor = [UIColor redColor];
    self.tableView.backgroundColor = [UIColor blackColor];
    
    feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:blogUrl];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkForConnection
{
    
    Reachability *internetReachability = [Reachability reachabilityWithHostName:blogUrl];
    NetworkStatus statusInternet = [internetReachability currentReachabilityStatus];
    if(statusInternet != ReachableViaWWAN)
    {
        UIAlertView *noConnectionAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Can't connect. Please check Internet connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil , nil];
            [noConnectionAlert show];
    }
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlogCell" forIndexPath:indexPath];
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey: blogTitleKey];

    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor blackColor];
  
    return cell;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:blogItemKey])
    {
        
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:blogItemKey])
    {
        
        [item setObject:title forKey:blogTitleKey];
        [item setObject:link forKey:blogLinkKey];
        
        [feeds addObject:[item copy]];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:blogTitleKey]) {
        [title appendString:string];
    } else if ([element isEqualToString:blogLinkKey]) {
        [link appendString:string];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.blogPostTable reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showBlogDetail"]) {
        
        NSIndexPath *indexPath = [self.blogPostTable indexPathForSelectedRow];
        
        NSString *string = [feeds[indexPath.row] objectForKey: blogLinkKey];
        [[segue destinationViewController] setUrl:string];
        
    }
}


@end
