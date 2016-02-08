//
//  APIKeyAndConstants.h
//  thePitApp
//
//  Created by David Rice on 7/13/15.
//  Copyright (c) 2015 thePitSlo. All rights reserved.
//

#ifndef thePitApp_APIKeyAndConstants_h
#define thePitApp_APIKeyAndConstants_h

static NSString *const orgname = @"The Pit SLO";

//LaunchNavigation Controller
static float const mainNavTop4ButtonHeightAndWidthFactor = 0.421875;
static float const mainNavBottm3ButtonHeightAndWidthFactor = 0.26875;
static float const mainNavAllButtonWidthGapFactor = 0.07407407407407;
static float const mainNavTop4ButtonHeightGapFactor = 0.05925925925926;
static float const mainNavBottom3Top4HeightGapFactor = 0.0625;
static float const mainNavBlogAndBeltButtonYFactor = 0.12916667;
static float const mainNavAllLeftButtonXFactor = 0.0625;

//Youtube Controller
static NSString *const kAPIKey = @"AIzaSyCaSlnmtgiTK9Hj_0lwBbwKiHWwixLoPPs";
static NSString *const kPlaylistID = @"UUIyJyNFVRJpce6wmYUNtMNw";
static NSString *const kParts = @"playlistItems?part=snippet&playlistId=";

static NSString *const baseVideoURL = @"https://www.youtube.com/watch?v=";
static NSString *const youtubeVideoKey = @"snippet";
static NSString *const youtubeTitleKey = @"title";
static NSString *const youtubeThumbnailKey = @"thumbnails";
static NSString *const youtubeDefaultKey = @"default";
static NSString *const youtubeUrlKey = @"url";
static NSString *const youtubeResIdKey = @"resourceId";
static NSString *const youtubeVidIdKey = @"videoId";


//Blog Controller
static NSString *const blogUrl = @"http://thepitslo.blogspot.com/feeds/posts/default?alt=rss";
static NSString *const blogItemKey = @"item";
static NSString *const blogTitleKey = @"title";
static NSString *const blogLinkKey = @"link";

//Schedule Controller
static NSString *const scheduleMonLink = @"https://spreadsheets.google.com/feeds/list/1ANODm-p1TJzR9DxR3FeAHDJyMRL_tdqut23PVckrtvI/od6/public/values";
static NSString *const scheduleTuesLink = @"https://spreadsheets.google.com/feeds/list/1OMhTvEgFYK5BAAKGXYqrtym5im41w6M76ogjGvYDV3Q/od6/public/values";
static NSString *const scheduleWedLink = @"https://spreadsheets.google.com/feeds/list/1L3EN3azU1zUJGvG_9Nrz44_oE3PQtBugbBkXyeqik-4/od6/public/values";
static NSString *const scheduleThurLink = @"https://spreadsheets.google.com/feeds/list/1CjKvwDF06gF1bu768Swpo6pLaFLRyxTRREmhntH4A08/od6/public/values";
static NSString *const scheduleFriLink = @"https://spreadsheets.google.com/feeds/list/1zm0GvQnqcePIT_WRXwAkAFYXWrrnJypZ-jlKtOsKUzY/od6/public/values";
static NSString *const scheduleSatLink = @"https://spreadsheets.google.com/feeds/list/1qyvb3NGCc8aKXBJ6Fa5XPTqcG7ksELEYU8DANCPYZTo/od6/public/values";

static NSString *const scheduleEntryKey = @"entry";
static NSString *const scheduleClassNameKey = @"gsx:classname";
static NSString *const scheduleStartHrKey = @"gsx:starthour";
static NSString *const scheduleStartMinKey = @"gsx:startminute";
static NSString *const scheduleEndHrKey = @"gsx:endhour";
static NSString *const scheduleEndMinKey = @"gsx:endminute";

static NSString *const scheduleMon = @"Mon";
static NSString *const scheduleTues = @"Tues";
static NSString *const scheduleWed = @"Wed";
static NSString *const scheduleThurs = @"Thurs";
static NSString *const scheduleFri = @"Fri";
static NSString *const scheduleSat = @"Sat";
static NSString *const scheduleSun = @"Sun";

//Belt Progress Controller
static NSString *const beltProgKempoAdultsLink = @"https://spreadsheets.google.com/feeds/list/0AsP6lrGC-fRldE43YWxHZGtwOHdiN0UwNU13OHRDRGc/od6/public/values";
static NSString *const beltProgKempoKidsLink = @"https://spreadsheets.google.com/feeds/list/0AsP6lrGC-fRldFRZTURoUDY3OVhIajl2cFUzUm5relE/od6/public/values";
static NSString *const beltProgJiuJitsuLink = @"https://spreadsheets.google.com/feeds/list/0AsP6lrGC-fRldEd4Wnp2ekxuS21XUlNFNkE2aTRSS2c/od6/public/values";

static NSString *const beltProgEntryKey = @"entry";
static NSString *const beltProgNameKey = @"gsx:name";
static NSString *const beltProgProgressKey = @"gsx:progress";
static NSString *const beltProgBeltColorKey = @"gsx:belt";
static NSString *const beltProgInfoLinkKey = @"gsx:infolink";

static NSString *const beltProgKempoAdults = @"Kempo Adults";
static NSString *const beltProgKempoKids = @"Kempo Kids";
static NSString *const beltProgJiuJitsu = @"Jiu Jitsu";

//Contact Us Controller
static NSString *const contactPhone = @"805-549-8800";
static NSString *const contactEmail= @" contact@thepitslo.com";
static NSString *const contactAddress= @"1285 Laurel Lane San Luis Obispo, CA 93401";

static NSString *const contactPhoneUrl = @"tel:18055498800";
static NSString *const contactMapAddress = @"1285 Laurel Lane San Luis Obispo California 93401";
static NSString *const contactGoogleMapString = @"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@";

static float const contactAllLabelsXRatio = 0.14375;
static float const contactAllLabelsWidthRatio = 0.225;
static float const contactAllButtonsXRatio = 0.39375;
static float const contactAllButtonsWidthRatio = 0.55625;
static float const contactAllLabelsAndButtonsHeightFactor = 0.0528169;
static float const contactAllLabelsAndButtonsHeightGapFactor = 0.11443662;
static float const contactCallLabelAndButtonYFactor = 0.14375;
static float const contactMapViewYFactor = 0.0625;
static float const contactMapViewXFactor = 0.875;
static float const contactMapViewHeightFactor = 0.55;
static float const contactMapViewWidthFactor = 0.4;

//Twitter Controller
static NSString *const twitterLink = @"https://twitter.com/THEPITSLO";

//Facebook Controller
static NSString *const facebookLink = @"https://www.facebook.com/pages/The-Pit-SLO/142224835849113";

#endif
