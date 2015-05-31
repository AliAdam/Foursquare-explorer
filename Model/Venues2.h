//
//  Venues.h
//  Foursquare explorer
//
//  Created by Ali Adam on 5/28/15.
//  Copyright (c) 2015 Ali Adam. All rights reserved.
//


//@interface Venues : NSObject
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Venues : NSManagedObject
@property (nonatomic, copy) NSString *name, *imgUrl, *venuesID,*Address;
@property (nonatomic) float distance, latitude, longitude;
@end
