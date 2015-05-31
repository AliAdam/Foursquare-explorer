//
//  Parser.h
//  Foursquare explorer
//
//  Created by Ali Adam on 5/28/15.
//  Copyright (c) 2015 Ali Adam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Venues.h"
#import "AppDelegate.h"

@interface Parser : NSObject
-(NSMutableArray*)getListOfVenues:(id) model latitude:(float )latitude longitude:(float)longitude radius:(float)radius ;
@end
