//
//  ProgressViewController.m
//  thePitApp
//
//  Created by David Rice on 1/11/14.
//  Copyright (c) 2014 David Rice. All rights reserved.
//

#import "ProgressViewController.h"

#import "BeltProgressTableController.h"

#import <QuartzCore/QuartzCore.h>

@interface ProgressViewController ()

@end

@implementation ProgressViewController

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
    UIBezierPath *maskPath, *maskPath2;
    
    maskPath = [UIBezierPath bezierPathWithRoundedRect:_hkAdultsButton.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(40.0, 40.0)];
    maskPath2 = [UIBezierPath bezierPathWithRoundedRect:_bjjButton.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(40.0, 40.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = _hkAdultsButton.bounds;
    maskLayer2.frame = _bjjButton.bounds;
    
    maskLayer.path = maskPath.CGPath;
    maskLayer2.path = maskPath2.CGPath;
    
    _hkAdultsButton.layer.mask = maskLayer;
    _bjjButton.layer.mask = maskLayer2;

    _hkKidsButton.backgroundColor = [UIColor redColor];
    _bjjButton.backgroundColor = [UIColor redColor];
	// Do any additional setup after loading the view.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BeltProgressTableController *bptc = [segue destinationViewController];
    bptc.beltType = [segue identifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
