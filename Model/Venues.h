//
//  Venues.h
//  Foursquare explorer
//
//  Created by Ali Adam on 5/29/15.
//  Copyright (c) 2015 Ali Adam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Venues : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSString * imgUrl;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * radius;
@property (nonatomic, retain) NSNumber * userLocationId;
@property (nonatomic, retain) NSNumber * userloclat;
@property (nonatomic, retain) NSNumber * userloclong;
@property (nonatomic, retain) NSString * venuesID;

@end
