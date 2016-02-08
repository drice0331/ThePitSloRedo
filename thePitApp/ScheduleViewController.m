//
//  ScheduleViewController.m
//  thePitApp
//
//  Created by David Rice on 10/25/15.
//  Copyright © 2015 thePitSlo. All rights reserved.
//

#import "ScheduleViewController.h"
#import "APIKeyAndConstants.h"

@interface ScheduleViewController ()
{
    NSXMLParser *parser;
    NSURL *dataLink;
    NSMutableArray *feeds;
    NSMutableDictionary *entry;
    NSMutableString *classname;
    NSMutableString *starthour;
    NSMutableString *endhour;
    NSMutableString *startminute;
    NSMutableString *endminute;
    NSString *element;
    
    int scrollTabIndex;
}
// EKEventStore instance associated with the current Calendar application
@property (nonatomic, strong) EKEventStore *eventStore;

// Default calendar associated with the above event store
@property (nonatomic, strong) EKCalendar *defaultCalendar;

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize the event store
    self.eventStore = [[EKEventStore alloc] init];
    
    [self.tableView setBackgroundColor:[UIColor blackColor]];
    [self.tableView setSeparatorColor:[UIColor redColor]];
    
    [self.flickTabView setBackgroundColor:[UIColor blackColor]];
    
    //Setting copyright label as footer of tableview
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
    label.text = orgname;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor redColor];
    label.font = [UIFont boldSystemFontOfSize:12.0f];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.tableView.tableFooterView = label;
    
    
    //Default to Monday schedule
    self.title = scheduleMon;
    scrollTabIndex = 0;
    dataLink = [NSURL URLWithString:scheduleMonLink];
    
    feeds = [[NSMutableArray alloc] init];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:dataLink];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self checkEventStoreAccessForCalendar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self checkEventStoreAccessForCalendar];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [feeds count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    NSMutableString *className = [[feeds objectAtIndex:indexPath.row] objectForKey: scheduleClassNameKey];
    NSMutableString *startHour = [[feeds objectAtIndex:indexPath.row] objectForKey: scheduleStartHrKey];
    NSMutableString *startMinute = [[feeds objectAtIndex:indexPath.row] objectForKey: scheduleStartMinKey];
    NSMutableString *endHour = [[feeds objectAtIndex:indexPath.row] objectForKey: scheduleEndHrKey];
    NSMutableString *endMinute = [[feeds objectAtIndex:indexPath.row] objectForKey: scheduleEndMinKey];
    
    NSString *startTime = [self formatTimeStringWithHour:startHour andMinute:startMinute];
    NSString *endTime = [self formatTimeStringWithHour:endHour andMinute:endMinute];
    
    // Set up the cell...
    //cell.textLabel.text = [NSString stringWithFormat:@"Row %d in Tab %d", indexPath.row + 1, self.flickTabView.selectedTabIndex + 1];
    cell.textLabel.text = className;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", startTime, endTime];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
    
    [cell setBackgroundColor:[UIColor blackColor]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self classTap:(int)indexPath.row];
}


#pragma mark -
#pragma mark FlickTabView Delegate & Data Source

- (void)scrollTabView:(FlickTabView*)scrollTabView didSelectedTabAtIndex:(NSInteger)index {
    scrollTabIndex = (int)index;
    if(index == 0) { //Mon
        dataLink = [NSURL URLWithString:scheduleMonLink];
        self.title = scheduleMon;
    }
    else if(index == 1) { //Tues
        dataLink = [NSURL URLWithString:scheduleTuesLink];
        self.title = scheduleTues;
    }
    else if(index == 2) { //Wed
        dataLink = [NSURL URLWithString:scheduleWedLink];
        self.title = scheduleWed;
    }
    else if(index == 3) { //Thurs
        dataLink = [NSURL URLWithString:scheduleThurLink];
        self.title = scheduleThurs;
    }
    else if(index == 4) { //Fri
        dataLink = [NSURL URLWithString:scheduleFriLink];
        self.title = scheduleFri;
    }
    else if(index == 5) { //Sat
        dataLink = [NSURL URLWithString:scheduleSatLink];
        self.title = scheduleSat;
    }
    else if(index == 6) {
        //no sunday schedule yet
        dataLink = [NSURL URLWithString:@""];
        self.title = scheduleSun;
    }
    
    feeds = [[NSMutableArray alloc] init];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:dataLink];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    [self.tableView reloadData];
    
}

//set number of tabs in flicktabview
- (NSInteger)numberOfTabsInScrollTabView:(FlickTabView*)scrollTabView {
    return 7;
}

- (NSString*)scrollTabView:(FlickTabView*)scrollTabView titleForTabAtIndex:(NSInteger)index {
    NSString *day;
    if(index == 0) {
        day = scheduleMon;
    }
    else if(index == 1) {
        day = scheduleTues;
    }
    else if(index == 2) {
        day = scheduleWed;
    }
    else if(index == 3) {
        day = scheduleThurs;
    }
    else if(index == 4) { //Fri
        day = scheduleFri;
    }
    else if(index == 5) {
        day = scheduleSat;
    }
    else if(index == 6) {
        //no sunday schedule yet
        day = scheduleSun;
    }
    
    return [NSString stringWithFormat:@"%@", day];
}

#pragma mark NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    //sets start element for parser -> setting a new value in entry, name, and progress arrays if "entry" is found by parser in xml data link
    element = elementName;
    
    if ([element isEqualToString:scheduleEntryKey])
    {
        
        entry    = [[NSMutableDictionary alloc] init];
        classname = [[NSMutableString alloc] init];
        starthour    = [[NSMutableString alloc] init];
        endhour = [[NSMutableString alloc] init];
        startminute = [[NSMutableString alloc] init];
        endminute = [[NSMutableString alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    //sets end element for parser -> setting a key-value pair to current entry dictionary, then adds the full entry to feed
    if ([elementName isEqualToString:beltProgEntryKey])
    {
        
        [entry setObject:classname forKey:scheduleClassNameKey];
        [entry setObject:starthour forKey:scheduleStartHrKey];
        [entry setObject:endhour forKey:scheduleEndHrKey];
        [entry setObject:startminute forKey:scheduleStartMinKey];
        [entry setObject:endminute forKey:scheduleEndMinKey];
        
        [feeds addObject:[entry copy]];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    //add to speific value arrays if string for specified value is found by parser
    if ([element isEqualToString:scheduleClassNameKey])
    {
        [classname appendString:string];
    }
    else if ([element isEqualToString:scheduleStartHrKey])
    {
        [starthour appendString:string];
    }
    else if([element isEqualToString:scheduleEndHrKey])
    {
        [endhour appendString:string];
    }
    else if ([element isEqualToString:scheduleStartMinKey])
    {
        [startminute appendString:string];
    }
    else if([element isEqualToString:scheduleEndMinKey])
    {
        [endminute appendString:string];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}

#pragma mark EKEventEditViewDelegate

// Overriding EKEventEditViewDelegate method to update event store according to user actions.
- (void)eventEditViewController:(EKEventEditViewController *)controller
          didCompleteWithAction:(EKEventEditViewAction)action
{
    NSLog(@"eventEditViewController - in");
    //ScheduleViewController * __weak weakSelf = self;
    // Dismiss the modal view controller
    [self dismissViewControllerAnimated:YES completion:^
     {
         if (action != EKEventEditViewActionCanceled)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 // Re-fetch all events happening in the next 24 hours
                 //weakSelf.eventsList = [self fetchEvents];
                 // Update the UI with the above events
                 //[weakSelf.tableView reloadData];
             });
         }
     }];
}


// Set the calendar edited by EKEventEditViewController to our chosen calendar - the default calendar.
- (EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:(EKEventEditViewController *)controller
{
    return self.defaultCalendar;
}

#pragma mark Access Calendar

// Check the authorization status of our application for Calendar
-(void)checkEventStoreAccessForCalendar
{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    switch (status)
    {
            // Update our UI if the user has granted access to their Calendar
        case EKAuthorizationStatusAuthorized: [self accessGrantedForCalendar];
            break;
            // Prompt the user for access to Calendar if there is no definitive answer
        case EKAuthorizationStatusNotDetermined: [self requestCalendarAccess];
            break;
            // Display a message if the user has denied or restricted access to Calendar
        case EKAuthorizationStatusDenied:
        case EKAuthorizationStatusRestricted:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Privacy Warning" message:@"Permission was not granted for Calendar"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            break;
        default:
            break;
    }
}


// Prompt the user for access to their Calendar
-(void)requestCalendarAccess
{
    [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
             ScheduleViewController * __weak weakSelf = self;
             // Let's ensure that our code will be executed from the main queue
             dispatch_async(dispatch_get_main_queue(), ^{
                 // The user has granted access to their Calendar; let's populate our UI with all events occuring in the next 24 hours.
                 [weakSelf accessGrantedForCalendar];
             });
         }
     }];
}


// This method is called when the user has granted permission to Calendar
-(void)accessGrantedForCalendar
{
    // Let's get the default calendar associated with our event store
    self.defaultCalendar = self.eventStore.defaultCalendarForNewEvents;
    // Enable the Add button
    
}


//Helper Methods

-(void) classTap:(int)index {
    
        [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
         {
             NSLog(@"access granted");
             EKEventEditViewController *addController = [[EKEventEditViewController alloc] init];
             
             EKEvent *e = [EKEvent eventWithEventStore:_eventStore];
             e.title = [[feeds objectAtIndex:index]objectForKey:scheduleClassNameKey];
             
             NSDate *today = [NSDate date];
            
             NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
             
             [gregorian setLocale:[NSLocale currentLocale]];
             
             NSDateComponents *nowComponents = [gregorian components:NSCalendarUnitYear | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:today];
             NSDateComponents *eventComponents = [gregorian components:NSCalendarUnitYear | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:today];
             
             NSLog(@"Todays weekday - %ld", (long)[nowComponents weekday]);
             
             int compWeekday = scrollTabIndex + 2;
             int nsCalendarWeekday = compWeekday % 7;
             
             int startHourInt = [[[feeds objectAtIndex:index] objectForKey:scheduleStartHrKey] intValue];
             int startMinuteInt = [[[feeds objectAtIndex:index] objectForKey:scheduleStartMinKey] intValue];
             
             [eventComponents setWeekday:nsCalendarWeekday];
             [eventComponents setHour:startHourInt];
             [eventComponents setMinute:startMinuteInt];
             [eventComponents setSecond:0];
             NSLog(@"Event weekday - %ld", (long)[eventComponents weekday]);
             
             
             if([nowComponents weekday]  >= compWeekday)
             {
                 if([nowComponents hour] >= [eventComponents hour])
                 {
                     //[eventComponents setWeek:([eventComponents week] + 1)];
                     [eventComponents setWeekOfYear:([eventComponents weekOfYear] + 1)];
                 }
             }
             
             
             
             NSDate *beginningOfWeek = [gregorian dateFromComponents:eventComponents];
             
             NSLog(@"nowcomponents weekday - %lu", (long)[nowComponents weekday]);
             
             e.startDate = beginningOfWeek;
             
             int endHourInt = [[[feeds objectAtIndex:index] objectForKey:scheduleEndHrKey] intValue];
             int endMinuteInt = [[[feeds objectAtIndex:index] objectForKey:scheduleEndMinKey] intValue];
             
             [eventComponents setHour:endHourInt];
             [eventComponents setMinute:endMinuteInt];
             NSDate *endOfWeek = [gregorian dateFromComponents:eventComponents];
             e.endDate = endOfWeek;
             e.location = orgname;
             
             addController.eventStore = self.eventStore;
             addController.event = e;
             
             addController.editViewDelegate = self;
             
             
             [self presentViewController:addController animated:YES completion:nil];
         }];
        
        
        
    
}

- (NSString *) formatTimeStringWithHour:(NSMutableString *)hour andMinute:(NSMutableString *)minute {
    
    NSString* ampm;
    NSString* formattedHour;
    NSString* formattedMinute;
    if([hour intValue] < 12) {
        if([hour intValue] == 0) {
            formattedHour = @"12";
        } else {
            formattedHour = hour;
        }
        ampm = @"am";
    } else { // >= 12
        formattedHour = hour;
        if([hour intValue] > 12) {
            int hourIntVal = [hour intValue];
            formattedHour = [NSString stringWithFormat:@"%i", hourIntVal - 12];
        }
        ampm = @"pm";
    }
    if([minute intValue] < 10) {
        formattedMinute = [NSString stringWithFormat:@"0%@", minute];
    } else {
        formattedMinute = minute;
    }
    
    return [NSString stringWithFormat:@"%@:%@ %@", formattedHour, formattedMinute, ampm];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
