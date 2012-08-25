//
//  TPNearbyViewController.m
//  Taste of Peru
//
//  Created by Pietro Rea on 8/25/12.
//  Copyright (c) 2012 Pietro Rea. All rights reserved.
//

#import "TPNearbyViewController.h"
#import <MapKit/MapKit.h>

@interface TPNearbyViewController ()

@property (strong, nonatomic) MKMapView* mapView;
@property (strong, nonatomic) UITableView* tableView;

@property (strong, nonatomic) IBOutlet UIView *centerView;
@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation TPNearbyViewController
@synthesize segmentedControl;
@synthesize centerView = _centerView;
@synthesize navigationBar = _navigationBar;

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
    
    //Load map as initial view
    self.mapView = [[MKMapView alloc] initWithFrame:self.centerView.frame];
    [self.view addSubview:self.mapView];
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

@end
