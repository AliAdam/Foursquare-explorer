//
//  ViewController.m
//  Foursquare explorer
//
//  Created by Ali Adam on 5/27/15.
//  Copyright (c) 2015 Ali Adam. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

{
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _listTable.backgroundColor=[UIColor clearColor];
    _expanded=true;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = 1000;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
     self.mapView.delegate = (id)self;
    [self.mapView bringSubviewToFront:self.expand];
     [self.mapView bringSubviewToFront:self.FilterSlider];
     indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 400.0, 400.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
   }

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
        tableexpanded=_listTable.frame ;
        mapexpanded=_mapView.frame;
        h=self.expand.frame.size.height;
        tablefull=CGRectMake(tableexpanded.origin.x, mapexpanded.origin.y,tableexpanded.size.width,self.view.frame.size.height);
        mapfull=CGRectMake(mapexpanded.origin.x, mapexpanded.origin.y,mapexpanded.size.width,self.view.frame.size.height);
        tablecolaps =CGRectMake(tableexpanded.origin.x, self.view.frame.size.height,tableexpanded.size.width,0);
        mapcolaps= CGRectMake(mapexpanded.origin.x, mapexpanded.origin.y,mapexpanded.size.width,0);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    userlatitude=newLocation.coordinate.latitude ;
    userlongitude=newLocation.coordinate.longitude;
    [self loadveneusList];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError*)error{
    if( [(NSString *)[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"] ){
        userlatitude = 40.7;
        userlongitude = -74;
    }
    [self loadveneusList];
      [locationManager stopUpdatingLocation];
      return;
}
- (IBAction)SliderValueChanged:(id)sender
{
    [self loadveneusList];
    }
- (void)loadveneusList
{
    [indicator startAnimating];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        [self loadveneusList:userlatitude longitude:userlongitude radius:_FilterSlider.value*100];
    } else {
        NSLog(@"There IS internet connection");
        [self ConnectToFoursquareApi:userlatitude longitude:userlongitude radius:_FilterSlider.value*100];
    }
}
-(void)ConnectToFoursquareApi:(float )latitude longitude:(float)longitude radius:(float)radius  {
    [_mapView removeAnnotations: [_mapView annotations]];
    MKCoordinateRegion region = { { latitude , longitude }, { 0.009f , 0.009f } };
    [_mapView setRegion: region animated: YES];
    NSString *stringURL = [NSString stringWithFormat: @"http://api.foursquare.com/v2/venues/search?client_id=%@&client_secret=%@&ll=%f,%f&radius=%f&query=%@&v=20140806&m=foursquare", ClientId,ClientSecret,latitude,longitude,radius,@""];
    stringURL = [stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (connectionError)
         {
             NSLog(@"ERROR CONNECTING DATA FROM SERVER: %@", connectionError.localizedDescription);
         } else
         {
             Parser *parser=[[Parser alloc]init];
            self.VenuesList= [parser getListOfVenues:data latitude:latitude longitude:longitude radius:radius];
             [indicator stopAnimating];
             if(self.VenuesList.count>0)
             {
                 [_mapView removeAnnotations: [_mapView annotations]];
                 [self.listTable reloadData];
             }
             else
             {

                 UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"No Data"
                                                                 message:@"No Venues Found. Offline Data will be showen"
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
                 [self loadveneusList:userlatitude longitude:userlongitude radius:_FilterSlider.value*100];

             }
         }
     }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [locationManager stopUpdatingLocation];
    locationManager=nil;
    locationManager.delegate=nil;
}

#pragma mark - UITableViewDelegate methods
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
        static NSString *CellIdentifier = @"SepCell";
        SepCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
            cell = [[SepCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.title.text =@"Venues List";
        [cell.expandtable addTarget:self action:@selector(expandecolpastable:)forControlEvents:UIControlEventTouchUpInside];
        return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString * const det = @"Cell";
        Cell  *cell=nil;
        if (indexPath.row % 2 == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:det];
            if (!cell) {
                cell = [[Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:det];
            }
            [cell layoutIfNeeded];
            CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            return size.height;
        }
        else {
            return 5;
        }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger numOfRowsIncludeSeparator = 0;
    if ([_VenuesList count]==0)
    {
        return numOfRowsIncludeSeparator;
    }
    else{
        NSInteger numOfSeperators = _VenuesList.count - 1;
        numOfRowsIncludeSeparator = _VenuesList.count + numOfSeperators;
        return numOfRowsIncludeSeparator;
    }

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger indexIn = indexPath.row / 2;
    if (indexPath.row % 2 == 0) {
        static NSString *CellIdentifier = @"Cell";
        Cell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
            cell = [[Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
         NSManagedObject *venObj = self.VenuesList[indexIn];
        [cell.layer setCornerRadius:10.0f];
        [cell.layer setMasksToBounds:YES];
        [cell.layer setBorderWidth:2.0f];
        [cell.layer setBorderColor:[UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1.0].CGColor];
        cell.backgroundColor=[UIColor whiteColor];
        cell.hidden=false;
        cell.Name.preferredMaxLayoutWidth = cell.Name.frame.size.width;
        cell.Address.preferredMaxLayoutWidth = cell.Distance.frame.size.width;
        cell.image.layer.masksToBounds = YES;
        cell.image.layer.cornerRadius = cell.image.bounds.size.height/2;
        cell.Distance.layer.masksToBounds = YES;
        cell.Distance.layer.cornerRadius = cell.Distance.bounds.size.height/2;
        cell.Name.text =[venObj valueForKey:@"name"];
        
        cell.Address.text =[NSString stringWithFormat:@"%@",[venObj valueForKey:@"address"]];
        
          cell.Distance.text =[NSString stringWithFormat:@"%0.0f M",[[venObj valueForKey:@"distance"] floatValue]];
        
        NSLog(@"venObj.imgUrl=%@",[venObj valueForKey:@"imgUrl"]);
        cell.image.imageURL=[NSURL URLWithString:[venObj valueForKey:@"imgUrl"]];
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [[venObj valueForKey:@"latitude"] floatValue];
        coordinate.longitude = [[venObj valueForKey:@"longitude"] floatValue];
        point.coordinate=coordinate;
        point.title = [venObj valueForKey:@"name"];
        point.subtitle =[NSString stringWithFormat:@"%f",[[venObj valueForKey:@"distance"] floatValue]];
        [self.mapView addAnnotation:point];
        return cell;

    }
    else
    {
        static NSString *CellIdentifier = @"SepCell";
        SepCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
            cell = [[SepCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor=[UIColor clearColor];
        cell.hidden=true;
        cell.userInteractionEnabled =NO;
        cell.expandtable.hidden=true;
        cell.title.hidden=true;
        return cell;

    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView *myView = cell.contentView;
    CALayer *layer = myView.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -1000;
    
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI*0.5, 1.0f, 0.0f, 0.0f);
    //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -M_PI*0.5, 1.0f, 0.0f, 0.0f);
    layer.transform = rotationAndPerspectiveTransform;
    [UIView animateWithDuration:.5 animations:^{
        layer.transform = CATransform3DIdentity;
    }];
    
    
}
-(void)loadveneusList :(float )latitude longitude:(float)longitude radius:(float)radius{
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext  =[appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Venues"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"radius = %f && userloclong = %f && userloclat = %f", radius,longitude,latitude];
      fetchRequest.predicate=predicate;
    self.VenuesList = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [indicator stopAnimating];
    [self.listTable reloadData];
}
- (IBAction)expandecolpasseaction:(id)sender {
    _listTable.translatesAutoresizingMaskIntoConstraints=YES;
    _mapView.translatesAutoresizingMaskIntoConstraints=YES;
    if (_mapfulexpanded) {
        _tablefullexpanded=false;
        _mapfulexpanded=false;
        [self.mapView removeFromSuperview];
        self.mapView.frame=mapexpanded;
        [self.view addSubview:self.mapView];
        self.listTable.hidden=false;
    }
    else
    {
        _mapfulexpanded=false;
        _tablefullexpanded=true;
        [self.mapView removeFromSuperview];
        self.mapView.frame=mapcolaps;
        [self.view addSubview:self.mapView];
        self.self.listTable.translatesAutoresizingMaskIntoConstraints = YES;
        [self.self.listTable setFrame:tablefull];
        [self.view layoutIfNeeded];
    }
}

- (void)expandecolpastable:(UIButton*)sender
{
    _listTable.translatesAutoresizingMaskIntoConstraints=YES;
    _mapView.translatesAutoresizingMaskIntoConstraints=YES;
   
    if (_tablefullexpanded) {
        [self.mapView removeFromSuperview];
        self.mapView.frame=mapexpanded;
        [self.view addSubview:self.mapView];
        _mapfulexpanded =false;
        _tablefullexpanded=false;
        self.listTable.translatesAutoresizingMaskIntoConstraints = YES;
        [self.listTable setFrame:tableexpanded];
        [self.view layoutIfNeeded];
    }
    else
    {
        _mapfulexpanded=true;
        _tablefullexpanded=false;
        
        [self.mapView removeFromSuperview];
        self.mapView.frame=mapfull;
        [self.view addSubview:self.mapView];
    
        self.listTable.hidden=true;
    }
    
}

@end
