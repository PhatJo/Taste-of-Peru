//
//  TPGetRestaurantListWebOperation.h
//  Taste of Peru
//
//  Created by Pietro Rea on 8/26/12.
//  Copyright (c) 2012 Pietro Rea. All rights reserved.
//

#import "TPBaseWebServiceOperation.h"

@interface TPGetRestaurantListWebOperation : TPBaseWebServiceOperation

@property (strong, nonatomic) NSNumber* latitude;
@property (strong, nonatomic) NSNumber* longitude;
@property (strong, nonatomic) NSString* clientID;
@property (strong, nonatomic) NSString* clientSecret;
@property (strong, nonatomic) NSString* categoryID;

@end
