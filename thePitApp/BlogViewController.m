//
//  BlogViewController.m
//  thePitApp
//
//  Created by David Rice on 10/24/13.
//  Copyright (c) 2013 David Rice. All rights reserved.
//

#import "BlogViewController.h"

#import "BlogDetailViewController.h"

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
    
	// Do any additional setup after loading the view.
    feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://thepitslo.blogspot.com/feeds/posts/default?alt=rss"];
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
    
    Reachability *internetReachability = [Reachability reachabilityWithHostName:@"http://thepitslo.blogspot.com/feeds/posts/default?alt=rss"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];

    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = [UIColor whiteColor];
  
    return cell;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"])//@"item"
    {
        
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"])//@"item"
    {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        
        [feeds addObject:[item copy]];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.blogPostTable reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showBlogDetail"]) {
        
        NSIndexPath *indexPath = [self.blogPostTable indexPathForSelectedRow];
        //NSDictionary *video = feeds[indexPath.row];// not here
        //NSDictionary *content = [video valueForKeyPath:@"media$group.media$content"][0];
        //NSString *url = [content valueForKeyPath:@"url"];
        //NSLog([content valueForKeyPath:<#(NSString *)#>])
        
        //NSString *uri = [feeds[indexPath.row] objectForKey:@"uri"];
        
        NSString *string = [feeds[indexPath.row] objectForKey: @"link"];
        //NSLog(string);
        [[segue destinationViewController] setUrl:string];
        
    }
}


@end
