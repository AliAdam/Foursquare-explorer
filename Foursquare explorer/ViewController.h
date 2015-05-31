//
//  ViewController.h
//  Foursquare explorer
//
//  Created by Ali Adam on 5/27/15.
//  Copyright (c) 2015 Ali Adam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Parser.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "SDKDemoAPIKey.h"
#import "SepCell.h"
#import "Cell.h"
@interface ViewController : UIViewController<CLLocationManagerDelegate,UITableViewDataSource, UITableViewDelegate,NSURLConnectionDelegate >
{
    CGRect tableexpanded;
    CGRect mapexpanded;
    CGRect tablefull;
    CGRect mapfull;
    CGRect tablecolaps;
    CGRect mapcolaps;
    float h,w,userlongitude,userlatitude;
    CLLocationManager *locationManager;
    UIActivityIndicatorView *indicator ;
}

@property (nonatomic, strong) IBOutlet UITableView * listTable;
@property (weak, nonatomic) IBOutlet UIButton *expand;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, assign) BOOL expanded;
@property (nonatomic, assign) BOOL collaps;
@property (nonatomic, assign) BOOL mapfulexpanded;
@property (nonatomic, assign) BOOL tablefullexpanded;
@property (weak, nonatomic) IBOutlet UISlider *FilterSlider;
@property (nonatomic, retain) NSMutableArray *VenuesList;
- (IBAction)SliderValueChanged:(id)sender;

@end

