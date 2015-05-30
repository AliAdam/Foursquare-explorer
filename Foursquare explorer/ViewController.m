//
//  ViewController.m
//  Foursquare explorer
//
//  Created by Ali Adam on 5/27/15.
//  Copyright (c) 2015 Ali Adam. All rights reserved.
//

#import "ViewController.h"
#import "SepCell.h"
#import "Cell.h"
#import "Parser.h"
#import "SDKDemoAPIKey.h"
@interface ViewController ()

{
    CGRect tableexpanded;
    CGRect mapexpanded;
    CGRect tablefull;
    CGRect mapfull;
    CGRect tablecolaps;
    CGRect mapcolaps;
    float h,w;
    CLLocationManager *locationManager;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _listTable.translatesAutoresizingMaskIntoConstraints=YES;
    _mapView.translatesAutoresizingMaskIntoConstraints=YES;
    _listTable.backgroundColor=[UIColor clearColor];
    _expanded=true;
    _collaps =false;
    _tablefullexpanded=false;
    _mapfulexpanded=false;
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
       [locationManager stopUpdatingLocation];
    locationManager=nil;
    locationManager.delegate=nil;
    
}
@end
