//
//  BeltProgressImage.m
//  thePitApp
//
//  Created by David Rice on 2/11/14.
//  Copyright (c) 2014 David Rice. All rights reserved.
//

#import "BeltProgressImage.h"

@implementation BeltProgressImage

#pragma mark - Properties

NSArray *keys;
NSArray *colorImagePaths;
NSDictionary *colors;// = [NSDictionary dictionaryWithObjects:keys forKeys:colorImagePaths];

#pragma mark - end properties

- (NSString*)getColor
{
    return _color;
}

- (void)setColor:(NSString*)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (NSUInteger) getProgressValue
{
    return _progressValue;
}

- (void)setProgressValue:(NSUInteger)progressValue
{
    _progressValue = progressValue;
    [self setNeedsDisplay];
}

- (NSString*) getGroupName
{
    return _groupName;
}

- (void)setGroupName:(NSString *)groupName
{
    _groupName = groupName;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


#define CORNER_RADIUS 0.0

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    //NSAttributedString *text;
    //UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    //[roundedRect addClip];
    /*
    if([_groupName isEqualToString:@"HKAdults" ])
    {
        keys = [NSArray arrayWithObjects:@"White", @"Yellow", @"Orange", @"Purple", @"Blue", @"Blue w/ black",
                @"Green", @"Green w/ black", @"Red", @"Red w/ black", @"Brown", @"Brown/Black", @"Black", nil];
        colorImagePaths = [NSArray arrayWithObjects:@"white.jpg", @"yellow.jpg", @"orange.jpg", @"purple.jpg", @"blue.jpg",
            @"blueblack.jpg", @"green.jpg", @"greenblack.jpg", @"red.jpg", @"redblack.jpg", @"brown.jpg", @"brownblack.jpg", @"black.jpg", nil];
        
    }
    else if([_groupName isEqualToString:@"HKKids" ])
    {
        keys = [NSArray arrayWithObjects:@"White", @"Yellow", @"Orange", @"Purple", @"Blue", @"Blue w/ black",
                @"Green", @"Green w/ white",@"Green w/ black", @"Red", @"Red w/ white", @"Red w/ black", @"Brown",
                @"Brown w/ white", @"Brown w/ Black", @"Black", nil];
        colorImagePaths = [NSArray arrayWithObjects:@"white.jpg", @"yellow.jpg", @"orange.jpg", @"purple.jpg", @"blue.jpg",
                @"blueblack.jpg", @"green.jpg", @"greenwhite.jpg", @"greenblack.jpg", @"red.jpg", @"redwhite.jpg", @"redblack.jpg", @"brown.jpg", @"brownwhite", @"brownwithblack.jpg", @"black.jpg", nil];
    }
    else if([_groupName isEqualToString:@"PeeWees"])
    {
        keys = [NSArray arrayWithObjects:@"White", @"White w/ Yellow", @"White w/ Orange", @"White w/ Purple",  @"White w/ Blue", @"White w/ Green", @"White w/ Red", @"White w/ Brown", @"White w/ Black", @"White w/ Black x2", @"Yellow", @"Yellow w/ White", @"Yellow w/ Orange", @"Yellow w/ Black", @"Yellow/Orange", @"Yellow/Black", @"Camo", nil];
        colorImagePaths = [NSArray arrayWithObjects:@"white.jpg", @"whiteyellow.jpg", @"whiteorange.jpg", @"whitepurple.jpg",  @"whiteblue.jpg", @"whitegreen.jpg", @"whitered.jpg", @"whitebrown.jpg", @"whiteblack.jpg", @"whiteblack2.jpg", @"yellow.jpg", @"yellowwhite.jpg", @"yellowwithorange.jpg", @"yellowwithblack.jpg", @"yelloworange.jpg", @"yellowblack.jpg", @"camo.jpg", nil];
    }
    else //BJJ
    {
        keys = [NSArray arrayWithObjects:@"White", @"Blue", @"Purple", @"Brown", "Black", nil];
        colorImagePaths = [NSArray arrayWithObjects:@"white.jpg", @"blue.jpg", @"purple.jpg", @"brown.jpg", @"black.jpg", nil];
    }*/
    
    keys = [NSArray arrayWithObjects:@"White", @"Yellow", @"Orange", @"Purple", @"Blue", @"Green", @"Red", @"Brown", @"Black",  nil];
    colorImagePaths = [NSArray arrayWithObjects:@"white.jpg", @"yellow.jpg", @"orange.jpg", @"purple.jpg", @"blue.jpg", @"green.jpg", @"red.jpg", @"brown.jpg", @"black.jpg", nil];
    
    colors = [NSDictionary dictionaryWithObjects:colorImagePaths forKeys:keys];
    
    UIImage *beltImage = [UIImage imageNamed:@"belt_transparent.png"];
    NSString *backgroundImagePath = [colors objectForKey:_color];
    UIImage *backgroundImage = [UIImage imageNamed:backgroundImagePath];
    
    UIImageView *view = [[UIImageView alloc] initWithImage:beltImage];
    
    //CGRect background = view.frame;
    CGFloat widthFraction = view.frame.size.width/37.50;
    
    //30,32,34 , 600 belt width, 660 width from origin, 730 total width
    
    /*
    CGFloat x = view.frame.origin.x
    CGFloat y = view.frame.origin.y
    CGFloat width = _progressValue*widthFraction;
     
    CGRect background = CGRectMake(x, y, width, view.frame.size.height)
    */
    
    //UIGraphicsBeginImageContextWithOptions - use later for better image
    
    
    
    UIGraphicsBeginImageContext(beltImage.size);
    
    
    [backgroundImage drawInRect:CGRectMake(0, 0, (widthFraction*(3.97 + _progressValue)), backgroundImage.size.height)];
    //[beltImage drawInRect:CGRectMake(backgroundImage.size.width - beltImage.size.width, backgroundImage.size.height - beltImage.size.height, beltImage.size.width, beltImage.size.height)];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [result drawInRect:rect];
    [beltImage drawInRect:rect];
    
}


@end
