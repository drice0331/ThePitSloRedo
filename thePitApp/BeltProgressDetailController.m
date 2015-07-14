//
//  BeltProgressDetailController.m
//  thePitApp
//
//  Created by David Rice on 1/26/14.
//  Copyright (c) 2014 David Rice. All rights reserved.
//

#import "BeltProgressDetailController.h"

@interface BeltProgressDetailController ()

@end

@implementation BeltProgressDetailController

@synthesize beltProgress;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _nameLabel.text = [_beltProgressDetailInfo objectAtIndex: 0];
    
    int progressValue = [[_beltProgressDetailInfo objectAtIndex:1] intValue];
    //NSLog(@"%lu", (unsigned long)_beltProgressDetailInfo.count);
    NSString *beltcolor = [_beltProgressDetailInfo objectAtIndex:2];
    NSString *groupName = [_beltProgressDetailInfo objectAtIndex:3];
    
    _beltColorLabel.text = beltcolor;
    _dayProgressLabel.text = [self getProgressString:progressValue];
    
    //NSString *beltcolor = @"Red";
    [beltProgress setProgressValue:progressValue];
    [beltProgress setColor:beltcolor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*)getProgressString:(int)progressVal
{
    NSMutableString *progressString = [_beltProgressDetailInfo objectAtIndex:1];
    if(progressVal == 1)
    {
        [progressString appendString:@" Day"];
    }
    else
    {
        [progressString appendString:@" Days"];
    }
    return progressString;
}

@end
