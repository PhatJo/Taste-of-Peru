//
//  TPGetRestaurantListWebOperation.m
//  Taste of Peru
//
//  Created by Pietro Rea on 8/26/12.
//  Copyright (c) 2012 Pietro Rea. All rights reserved.
//

#import "TPGetRestaurantListWebOperation.h"
#import "TPGetRestaurantListResult.h"
#import "AFNetworking.h"
#import "TPSettings.h"
#import "NSObject+Extensions.h"

#define RESPONSE_DICTIONARY @"response"
#define VENUES_ARRAY @"venues"

#define RESTAURANT_ID @"id"
#define RESTAURANT_NAME @"name"
#define RESTAURANT_CONTACT_DICTIONARY @"contact"
#define RESTAURANT_PHONE @"formattePhone"
#define RESTAURANT_LOCATION_DICTIONARY @"location"
#define RESTAURANT_ADDRESS @"address"
#define RESTAURANT_CROSS_STREET @"crossStreet"
#define RESTAURANT_LATITUDE @"lat"
#define RESTAURANT_LONGITUDE @"lng"
#define RESTAURANT_DISTANCE @"distance"
#define RESTAURANT_POSTAL_CODE @"postalCode"
#define RESTAURANT_CITY @"city"
#define RESTAURANT_STATE @"state"
#define RESTAURANT_COUNTRY @"country"

@interface TPGetRestaurantListWebOperation ()

@property (strong, nonatomic) AFJSONRequestOperation* httpOperation;

@end

@implementation TPGetRestaurantListWebOperation 

- (void)performOperation {
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString* baseString = @"https://api.foursquare.com/v2/venues/search?";
    NSString* urlString = [baseString stringByAppendingFormat:@"ll=%f,%f&client_id=%@&client_secret=%@&categoryId=%@&v=%@", [self.latitude doubleValue], [self.longitude doubleValue], self.clientID, self.clientSecret, self.categoryID, dateString];
      
    __weak TPGetRestaurantListWebOperation* webOperation = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    self.httpOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [webOperation parseJson:JSON];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [webOperation performFailure];
    }];
    [self.httpOperation start];
}

- (void)parseJson:(NSDictionary*)jsonDict {
    
    NSDictionary* responseDictionary = [[jsonDict objectForKey:RESPONSE_DICTIONARY] valueOrNil];
    NSArray* venuesArray = [[responseDictionary objectForKey:VENUES_ARRAY] valueOrNil];
    
    TPGetRestaurantListResult* result = [[TPGetRestaurantListResult alloc] init];
    result.restaurantArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary* restaurantDictionary in venuesArray) {
        
        TPRestaurant* restaurant = [[TPRestaurant alloc] init];
        restaurant.name = [[restaurantDictionary objectForKey:RESTAURANT_NAME] valueOrNil];
        restaurant.ID = [[restaurantDictionary objectForKey:RESTAURANT_ID] valueOrNil];
        
        NSDictionary* contactDictionary = [[restaurantDictionary objectForKey:RESTAURANT_CONTACT_DICTIONARY] valueOrNil];
        restaurant.phone = [[contactDictionary objectForKey:RESTAURANT_PHONE] valueOrNil];
        
        NSDictionary* locationDictionary = [[restaurantDictionary objectForKey:RESTAURANT_LOCATION_DICTIONARY] valueOrNil];
        restaurant.address = [[locationDictionary objectForKey:RESTAURANT_ADDRESS] valueOrNil];
        restaurant.crossStreet = [[locationDictionary objectForKey:RESTAURANT_CROSS_STREET] valueOrNil];
        restaurant.longitude = [[locationDictionary objectForKey:RESTAURANT_LONGITUDE] valueOrNil];
        restaurant.latitude = [[locationDictionary objectForKey:RESTAURANT_LATITUDE] valueOrNil];
        restaurant.distance = [[locationDictionary objectForKey:RESTAURANT_DISTANCE] valueOrNil];
        restaurant.city = [[locationDictionary objectForKey:RESTAURANT_CITY] valueOrNil];
        restaurant.postalCode = [[locationDictionary objectForKey:RESTAURANT_POSTAL_CODE] valueOrNil];
        restaurant.state = [[locationDictionary objectForKey:RESTAURANT_STATE] valueOrNil];
        restaurant.country = [[locationDictionary objectForKey:RESTAURANT_COUNTRY] valueOrNil];
        
        //Only include restaurants that have at least a street address
        
        if (restaurant.address) {
            [result.restaurantArray addObject:restaurant];
        }
    }
    
    self.result = result;
    [self performSuccess];
}

- (void)cancel {
    [self.httpOperation cancel];
    [super cancel];
}

@end
