//
//  TPNearbyViewController.m
//  Taste of Peru
//
//  Created by Pietro Rea on 8/25/12.
//  Copyright (c) 2012 Pietro Rea. All rights reserved.
//

#import "TPNearbyViewController.h"
#import <MapKit/MapKit.h>

#define LIST_VIEW_INDEX 0
#define MAP_VIEW_INDEX 1

@interface TPNearbyViewController ()

@property (strong, nonatomic) MKMapView* mapView;
@property (strong, nonatomic) UITableView* tableView;

@property (strong, nonatomic) IBOutlet UIView *centerView;
@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

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
        [self presentMapView];
    else
        [self presentTableView];
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

#pragma mark - Miscellaneous methods

- (void)presentMapView {
    
    [self.tableView  removeFromSuperview];
    [self.view addSubview:self.mapView];
    
}

- (void)presentTableView {
    
    [self.mapView  removeFromSuperview];
    [self.view addSubview:self.tableView];
    
}

@end
