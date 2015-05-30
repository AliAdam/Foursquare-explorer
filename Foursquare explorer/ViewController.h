//
//  ViewController.h
//  Foursquare explorer
//
//  Created by Ali Adam on 5/27/15.
//  Copyright (c) 2015 Ali Adam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate,UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) IBOutlet UITableView * listTable;
@property (weak, nonatomic) IBOutlet UIButton *expand;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@property (nonatomic, retain) MKUserLocation *userCurrentLocation;

@property (nonatomic, retain) NSURLConnection *urlConnection;
@property (nonatomic, assign) BOOL expanded;
@property (nonatomic, assign) BOOL collaps;
@property (nonatomic, assign) BOOL mapfulexpanded;
@property (nonatomic, assign) BOOL tablefullexpanded;

@end

