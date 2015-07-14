//
//  PageBeltTableController.m
//  thePitApp
//
//  Created by David Rice on 4/16/14.
//  Copyright (c) 2014 David Rice. All rights reserved.
//

#import "BeltProgressDetailController.h"
#import "PageBeltTableController.h"

@interface PageBeltTableController ()
{
    NSXMLParser *parser;
    NSURL *dataLink;
    NSMutableArray *feeds;
    NSMutableDictionary *entry;
    NSMutableString *name;
    NSMutableString *progress;
    NSMutableString *beltcolor;
    NSString *element;
}

@end

@implementation PageBeltTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    dataLink = [NSURL URLWithString:@"https://spreadsheets.google.com/feeds/list/0AsP6lrGC-fRldE43YWxHZGtwOHdiN0UwNU13OHRDRGc/od6/public/values"];
    self.navigationItem.title = _beltType;
    if([_beltType isEqualToString:@"Kempo Adults"])
    {
        dataLink = [NSURL URLWithString:@"https://spreadsheets.google.com/feeds/list/0AsP6lrGC-fRldE43YWxHZGtwOHdiN0UwNU13OHRDRGc/od6/public/values"];
    }
    else if([_beltType isEqualToString:@"Kempo Kids"])
    {
        dataLink = [NSURL URLWithString:@"https://spreadsheets.google.com/feeds/list/0AsP6lrGC-fRldFRZTURoUDY3OVhIajl2cFUzUm5relE/od6/public/values"];
    }
    else if([_beltType isEqualToString:@"Jiu Jitsu"])
    {
        dataLink = [NSURL URLWithString:@"https://spreadsheets.google.com/feeds/list/0AsP6lrGC-fRldEd4Wnp2ekxuS21XUlNFNkE2aTRSS2c/od6/public/values"];
    }
    
   //NSLog(_beltType);
    
    feeds = [[NSMutableArray alloc] init];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:dataLink];
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
    
    Reachability *internetReachability = [Reachability reachabilityWithHostName:[dataLink absoluteString]];
    NetworkStatus statusInternet = [internetReachability currentReachabilityStatus];
    if(statusInternet != ReachableViaWWAN)
    {
        UIAlertView *noConnectionAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Can't connect. Please check Internet connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil , nil];
        [noConnectionAlert show];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Return cell at specified indexPath, and sets textlabel to a name
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"gsx:name"];
    
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    //sets start element for parser -> setting a new value in entry, name, and progress arrays if "entry" is found by parser in xml data link
    element = elementName;
    
    if ([element isEqualToString:@"entry"])
    {
        
        entry    = [[NSMutableDictionary alloc] init];
        name = [[NSMutableString alloc] init];
        progress    = [[NSMutableString alloc] init];
        beltcolor = [[NSMutableString alloc] init];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    //sets end element for parser -> setting a key-value pair to current entry dictionary, then adds the full entry to feed
    if ([elementName isEqualToString:@"entry"])
    {
        
        [entry setObject:name forKey:@"gsx:name"];
        [entry setObject:progress forKey:@"gsx:progress"];
        [entry setObject:beltcolor forKey:@"gsx:belt"];
        
        [feeds addObject:[entry copy]];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    //add to speific value arrays if string for specified value is found by parser
    if ([element isEqualToString:@"gsx:name"])
    {
        [name appendString:string];
    }
    else if ([element isEqualToString:@"gsx:progress"])
    {
        [progress appendString:string];
    }
    else if([element isEqualToString:@"gsx:belt"])
    {
        [beltcolor appendString:string];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showBeltProgressDetail"]) {
        
        
        //
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *gname = [feeds[indexPath.row] objectForKey:@"gsx:name"];
        NSString *gprogress = [feeds[indexPath.row] objectForKey:@"gsx:progress"];
        NSString *gcolor = [feeds[indexPath.row] objectForKey:@"gsx:belt"];
        BeltProgressDetailController *bpdc = [segue destinationViewController];
        bpdc.beltProgressDetailInfo = [[NSArray alloc] initWithObjects: gname, gprogress, gcolor, _beltType, nil];
        
        //NSLog(gcolor);
        NSLog(@"%lu ", (unsigned long)bpdc.beltProgressDetailInfo.count);
        [segue destinationViewController];
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table vi
 ew.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */
@end