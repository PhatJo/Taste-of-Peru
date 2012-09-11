//
//  TPRestaurant.m
//  Taste of Peru
//
//  Created by Pietro Rea on 8/27/12.
//  Copyright (c) 2012 Pietro Rea. All rights reserved.
//

#import "TPRestaurant.h"
#import <CoreLocation/CoreLocation.h>

@implementation TPRestaurant

#pragma mark - MKAnnotation protocol methods

- (NSString*)title {
    return self.name;
}

- (NSString*)subtitle {
    return self.address;
}

- (CLLocationCoordinate2D)coordinate {

    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
    return location;
}

@end
