//
//  TPNearbyViewController.m
//  Taste of Peru
//
//  Created by Pietro Rea on 8/25/12.
//  Copyright (c) 2012 Pietro Rea. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "TPGetRestaurantListWebOperation.h"
#import "TPNearbyViewController.h"
#import "TPSettings.h"

#define MAP_VIEW_INDEX 0
#define LIST_VIEW_INDEX 1
#define METERS_PER_MILE 1609.34

@interface TPNearbyViewController ()

@property (strong, nonatomic) MKMapView* mapView;
@property (strong, nonatomic) UITableView* tableView;

@property (strong, nonatomic) IBOutlet UIView *centerView;
@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) TPGetRestaurantListWebOperation *getRestaurantListWebOperation;

- (IBAction)segmentedControlTapped:(id)sender;


@end

@implementation TPNearbyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.centerView.frame];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.centerView.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self presentMapView];
}

- (void)viewDidUnload
{
    [self setSegmentedControl:nil];
    [self setNavigationBar:nil];
    [self setCenterView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)segmentedControlTapped:(id)sender {
    
    if (self.segmentedControl.selectedSegmentIndex == LIST_VIEW_INDEX)
        [self presentTableView];
    else
        [self presentMapView];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TPSettingsCell"];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TPSettingsCell"];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - MKMapKitDelegate methods

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    MKCoordinateRegion coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 20 * METERS_PER_MILE, 20 * METERS_PER_MILE);
    [self.mapView setRegion:coordinateRegion animated:YES];
    
    [self performGetRestaurantListWebOperation:userLocation.location.coordinate];
}

#pragma mark - Miscellaneous methods

- (void)presentMapView {
    
    [self.tableView  removeFromSuperview];
    [self.view addSubview:self.mapView];
    
}

- (void)presentTableView {
    
    [self.mapView  removeFromSuperview];
    [self.view addSubview:self.tableView];
    
}

#pragma mark - Miscellaneous

- (void)performGetRestaurantListWebOperation:(CLLocationCoordinate2D)coordinates {
    
    self.getRestaurantListWebOperation = [[TPGetRestaurantListWebOperation alloc] init];
    self.getRestaurantListWebOperation.latitude = [NSNumber numberWithDouble:(double)coordinates.latitude];
    self.getRestaurantListWebOperation.longitude = [NSNumber numberWithDouble:(double)coordinates.longitude];
    self.getRestaurantListWebOperation.clientID = [[TPSettings settings] clientID];
    self.getRestaurantListWebOperation.clientSecret = [[TPSettings settings] clientSecret];
    self.getRestaurantListWebOperation.categoryID = [[TPSettings settings] categoryID];
    
    __weak TPNearbyViewController* viewController;
    [self.getRestaurantListWebOperation setSuccessBlock:^(id result) {
        [viewController handleRestaurantListResponse];
    }];
    
    [self.getRestaurantListWebOperation startAsynchronous];
}

- (void)handleRestaurantListResponse {
    
}

@end
