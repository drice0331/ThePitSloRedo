//
//  BeltProgressDetailController.h
//  thePitApp
//
//  Created by David Rice on 1/26/14.
//  Copyright (c) 2014 David Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeltProgressImage.h"

@interface BeltProgressDetailController : UIViewController
@property (strong, nonatomic) NSArray *beltProgressDetailInfo;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *beltColorLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayProgressLabel;

@property (weak, nonatomic) IBOutlet BeltProgressImage *beltProgress;


- (NSString*)getProgressString:(int)progressVal;

@end
