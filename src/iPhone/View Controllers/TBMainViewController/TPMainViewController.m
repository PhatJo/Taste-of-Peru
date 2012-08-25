//
//  TPMainViewController.m
//  Taste of Peru
//
//  Created by Pietro Rea on 8/25/12.
//  Copyright (c) 2012 Pietro Rea. All rights reserved.
//

#import "TPMainViewController.h"
#import "TPNearbyViewController.h"
#import "TPSearchViewController.h"
#import "TPFavoritesViewController.h"
#import "TPSettingsViewController.h"

@interface TPMainViewController ()

@property (strong, nonatomic) UITabBarController* tabBarController;

@property (strong, nonatomic) TPNearbyViewController* nearbyViewController;
@property (strong, nonatomic) TPSearchViewController* searchViewController;
@property (strong, nonatomic) TPFavoritesViewController* favoritesViewController;
@property (strong, nonatomic) TPSettingsViewController* settingsViewController;

@end

@implementation TPMainViewController

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
    
    //Set up tab bar controller
    
    self.tabBarController = [[UITabBarController alloc] init];
    
    NSMutableArray* viewControllers = [[NSMutableArray alloc] init];
    self.nearbyViewController = [[TPNearbyViewController alloc] init];
    self.searchViewController = [[TPSearchViewController alloc] init];
    self.favoritesViewController = [[TPFavoritesViewController alloc] init];
    self.settingsViewController = [[TPSettingsViewController alloc] init];
    
    [viewControllers addObject:self.nearbyViewController];
    [viewControllers addObject:self.searchViewController];
    [viewControllers addObject:self.favoritesViewController];
    [viewControllers addObject:self.settingsViewController];
    
    self.nearbyViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Nearby" image:[UIImage imageNamed:@"74-location"] tag:0];
    self.searchViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Search" image:[UIImage imageNamed:@"06-magnify"] tag:1];
    self.favoritesViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Favorites" image:[UIImage imageNamed:@"28-star"] tag:1];
    self.settingsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[UIImage imageNamed:@"20-gear-2"] tag:1];
                                            
    self.tabBarController.viewControllers = viewControllers;
    self.tabBarController.view.frame = self.view.bounds;
    [self.view addSubview:self.tabBarController.view];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
