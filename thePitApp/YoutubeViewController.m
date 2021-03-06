//
//  YoutubeViewController.m
//  thePitApp
//
//  Created by David Rice on 12/20/13.
//  Copyright (c) 2013 David Rice. All rights reserved.
//

#import "YoutubeViewController.h"
#import "APIKeyAndConstants.h"
#import "YoutubeDetailController.h"

@interface YoutubeViewController ()
{
    NSMutableArray *videos;
}
@end

@implementation YoutubeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@&key=%@", @"https://www.googleapis.com/youtube/v3/", kParts, kPlaylistID, kAPIKey];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    NSString *jsonString = [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingAllowFragments error:nil];
    
    //NSDictionary *feed = [[NSDictionary alloc] initWithDictionary:[jsonDict valueForKey:@"feed"]];
    videos = [NSMutableArray arrayWithArray:[jsonDict valueForKey:@"items"]];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkForConnection
{
    
    Reachability *internetReachability = [Reachability reachabilityWithHostName:@"www.youtube.com"];
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
    return videos.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *video = [videos[indexPath.row] valueForKey:youtubeVideoKey];
    NSString *title = [video valueForKeyPath:youtubeTitleKey];
    NSDictionary *thumbnails = [video valueForKey:youtubeThumbnailKey];
    NSDictionary *thumbnailData = [thumbnails valueForKey:youtubeDefaultKey];
    NSString *thumbnailImage = [thumbnailData valueForKeyPath:youtubeUrlKey];
    
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = title;
    
    NSURL *url = [[NSURL alloc] initWithString:thumbnailImage];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    cell.imageView.image = [UIImage imageWithData:imageData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    NSDictionary *video = [videos[indexPath.row] valueForKey:youtubeVideoKey];
    
    NSDictionary *content = [video valueForKey:youtubeResIdKey];
    NSString *videoId = [content valueForKeyPath:youtubeVideoKey];
    NSString *url = [NSString stringWithFormat:@"%@%@", baseVideoURL, videoId];
    
    //NSDictionary *content2 = [video valueForKeyPath:@"media$group.media$player"][0];
    //NSString *shareurl = [content2 valueForKeyPath:@"url"];
    
    YoutubeDetailController *detailViewController = [segue destinationViewController];
    detailViewController.url = url;
    //detailViewController.shareurl = shareurl;
    
}
@end
