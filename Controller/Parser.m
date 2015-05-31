//
//  Parser.m
//  Foursquare explorer
//
//  Created by Ali Adam on 5/28/15.
//  Copyright (c) 2015 Ali Adam. All rights reserved.
//

#import "Parser.h"

@implementation Parser
-(NSMutableArray*)getListOfVenues:(id) model latitude:(float )latitude longitude:(float)longitude radius:(float)radius {
    NSError *e = nil;
    NSDictionary *ResponseDictionary = [NSJSONSerialization JSONObjectWithData: (NSData*)model options: NSJSONReadingMutableContainers error: &e];
    
  NSArray *venuesarr =[[ResponseDictionary objectForKey: @"response"] objectForKey: @"venues"];
    NSMutableArray *venuesList=[[NSMutableArray alloc]init];
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context  =
    [appDelegate managedObjectContext];
    

    
    for (NSDictionary *venues in venuesarr)
    {
        NSString *name = [venues objectForKey: @"name"];
        NSString *venuesID = [venues objectForKey: @"id"];
        float distance = [[[venues objectForKey: @"location"] objectForKey: @"distance"]floatValue];
        NSString*Address=((NSArray*)[[venues objectForKey: @"location"] objectForKey: @"formattedAddress"])[0];
        float venObjlatitude = [[[venues objectForKey: @"location"] objectForKey: @"lat"] floatValue];
        float venObjlongitude = [[[venues objectForKey: @"location"] objectForKey: @"lng"] floatValue];
         NSArray *categories =[venues objectForKey: @"categories"];
        
        
        
        Venues * venObj = [NSEntityDescription
                                 insertNewObjectForEntityForName:@"Venues"
                                 inManagedObjectContext:context];
        if (categories.count!=0) {
               NSString *imgUrl= [NSString stringWithFormat:@"%@100%@",[[categories[0] objectForKey: @"icon"]objectForKey:@"prefix"],[[categories[0] objectForKey: @"icon"]objectForKey:@"suffix"]];
        venObj.imgUrl=imgUrl;
        }
        else
        {
           venObj.imgUrl=@"";
        }
        venObj.name=name;
        
        venObj.venuesID=venuesID;
        venObj.distance=[NSNumber numberWithFloat: distance];
        venObj.latitude=[NSNumber numberWithFloat: venObjlatitude];
        venObj.longitude=[NSNumber numberWithFloat: venObjlongitude];
        venObj.radius=[NSNumber numberWithFloat: radius];
        venObj.userloclat=[NSNumber numberWithFloat: latitude];
        venObj.userloclong=[NSNumber numberWithFloat: longitude];

        venObj.address=Address;
        
        [venuesList addObject:venObj];
        
        NSError *error;
        [context save:&error];
           }
    return venuesList;
}
@end
