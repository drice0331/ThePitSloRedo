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

    keys = [NSArray arrayWithObjects:
        @"White", @"WhiteYellow", @"WhiteOrange", @"WhitePurple", @"WhiteBlue", @"WhiteGreen", @"WhiteRed", @"WhiteBrown", @"WhiteBlack",
        @"Yellow", @"YellowWhite", @"YellowOrange", @"YellowBlack",
        @"Orange",
        @"Purple",
        @"Blue", @"BlueBlack",
        @"Green", @"GreenWhite", @"GreenBlack",
        @"Red", @"RedWhite", @"RedBlack",
        @"Brown", @"BrownWhite", @"BrownBlack",
        @"Black",
        @"Camo",  nil];
    colorImagePaths = [NSArray arrayWithObjects:
        @"white.jpg", @"white_w_yellow.png", @"white_w_orange.png", @"white_w_purple.png", @"white_w_blue.png", @"white_w_green.png", @"white_w_red.png", @"white_w_brown.png", @"white_w_black.png",
        @"yellow.png", @"yellow_w_white.png", @"yellow_w_orange.png", @"yellow_w_black.png",
        @"orange.jpg",
        @"purple.jpg",
        @"blue.png", @"blue_w_black.png",
        @"green.png", @"green_w_white.png", @"green_w_black.png",
        @"red.png", @"red_w_white.png", @"red_w_black.png",
        @"brown.png", @"brown_w_white.png", @"brown_w_black.png",
        @"black.jpg",
        @"camo.jpg", nil];
    
    colors = [NSDictionary dictionaryWithObjects:colorImagePaths forKeys:keys];
    
    UIImage *beltImage = [UIImage imageNamed:@"belt_transparent1.png"];
    NSString *backgroundImagePath = [colors objectForKey:_color];
    UIImage *backgroundImage = [UIImage imageNamed:backgroundImagePath];
    
    UIImageView *view = [[UIImageView alloc] initWithImage:beltImage];
    
    //CGRect background = view.frame;
    //CGFloat widthFraction = view.frame.size.width/37.50;
    CGFloat leftEdgeFraction = view.frame.size.width * .09726027;
    CGFloat widthFraction = (view.frame.size.width * .80958904)/100;
    //CGFloat leftEdgeFraction = self.frame.size.width * .09726027;
    //CGFloat widthFraction = (self.frame.size.width * .80958904)/100;
    
    //30,32,34 , 600 belt width, 660 width from origin, 730 total width
    
    /*
    CGFloat x = view.frame.origin.x
    CGFloat y = view.frame.origin.y
    CGFloat width = _progressValue*widthFraction;
     
    CGRect background = CGRectMake(x, y, width, view.frame.size.height)
    */
    
    //UIGraphicsBeginImageContextWithOptions - use later for better image
    
    
    
    UIGraphicsBeginImageContext(beltImage.size);
    

    UIImage *croppedBckImage = [self croppIngimageByImageName:backgroundImage toRect:CGRectMake(0, 0, leftEdgeFraction + (widthFraction*_progressValue), backgroundImage.size.height)];
    [croppedBckImage drawInRect:CGRectMake(0, 0, leftEdgeFraction + (widthFraction*_progressValue), backgroundImage.size.height)];

    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [result drawInRect:rect];
    [beltImage drawInRect:rect];
     
     
    
    
    
}

- (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}

@end
