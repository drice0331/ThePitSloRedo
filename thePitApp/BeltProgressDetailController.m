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
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    
    int progressValue = [[_beltProgressDetailInfo objectAtIndex:1] intValue];
    //NSLog(@"%lu", (unsigned long)_beltProgressDetailInfo.count);
    NSString *beltcolor = [_beltProgressDetailInfo objectAtIndex:2];
    //NSString *groupName = [_beltProgressDetailInfo objectAtIndex:3];
    
    
    _beltColorLabel.text = [NSString stringWithFormat:@"Rank: %@",beltcolor];
    _dayProgressLabel.text = [NSString stringWithFormat:@"Progress: %i %%", progressValue];
    [_beltInfoLink setTitle:@"Belt Info" forState:UIControlStateNormal];
    
    //Setting Belt Progress Image
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    [self setSubviewFrames:screenHeight and:screenWidth and:navigationBarHeight];
    
    [beltProgress setProgressValue:progressValue];
    [beltProgress setColor:beltcolor];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setSubviewFrames:(CGFloat)screenHeight and:(CGFloat)screenWidth and:(CGFloat)navBarHeight {
    
    CGFloat allViewWidth = screenWidth * 0.8;
    CGFloat allViewX = screenWidth * 0.1;
    CGFloat allLabelHeight = screenHeight * 0.035211;
    CGFloat fontSize = screenHeight * 0.3541667;
    
    UIFont* systemfont = [UIFont fontWithName:@"System" size:fontSize];
    
    if(allLabelHeight < 20) {
        allLabelHeight = 20;
    }
    
    CGFloat beltImageY = screenHeight * 0.20;
    CGFloat beltImageHeight = (screenWidth * 0.8)/1.2;
    
    CGFloat beltColorLabelY = (beltImageY + beltImageHeight) * 0.96;
    
    CGFloat progressLabelY = beltColorLabelY + allLabelHeight*2;
    
    CGFloat beltInfoLinkY = progressLabelY + allLabelHeight*2;
    
    //1. Student's name
    _nameLabel.frame = CGRectMake(allViewX, screenHeight * 0.03, allViewWidth, allLabelHeight);
    _nameLabel.font = systemfont;
    
    //2. BeltProgressImage
    beltProgress.frame = CGRectMake(allViewX, beltImageY, allViewWidth, beltImageHeight);
    
    //3. BeltColorLabel
    _beltColorLabel.frame = CGRectMake(allViewX, beltColorLabelY, allViewWidth, allLabelHeight);
    _beltColorLabel.font = systemfont;
    
    //4. BeltProgressLabel
    _dayProgressLabel.frame = CGRectMake(allViewX, progressLabelY, allViewWidth, allLabelHeight);
    _dayProgressLabel.font = systemfont;
    
    //5. BeltInfoLink
    _beltInfoLink.frame = CGRectMake(allViewX, beltInfoLinkY, allViewWidth, allLabelHeight);
    [_beltInfoLink.titleLabel setFont:systemfont];
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
- (IBAction)onBeltInfoLinkClick:(id)sender {
    
     NSString *beltInfoLink = [_beltProgressDetailInfo objectAtIndex:4];
    NSURL *link = [[NSURL alloc] initWithString:beltInfoLink];
    [[UIApplication sharedApplication] openURL:link];
    
}

@end
