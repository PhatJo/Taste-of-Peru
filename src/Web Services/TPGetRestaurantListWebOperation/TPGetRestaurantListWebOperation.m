//
//  TPGetRestaurantListWebOperation.m
//  Taste of Peru
//
//  Created by Pietro Rea on 8/26/12.
//  Copyright (c) 2012 Pietro Rea. All rights reserved.
//

#import "TPGetRestaurantListWebOperation.h"
#import "AFNetworking.h"
#import "TPSettings.h"

@interface TPGetRestaurantListWebOperation ()

@property (strong, nonatomic) AFJSONRequestOperation* httpOperation;

@end

@implementation TPGetRestaurantListWebOperation

- (void)performOperation {
    
    NSString* baseString = @"https://api.foursquare.com/v2/venues/search?";
    
    NSString* urlString = [baseString stringByAppendingFormat:@"ll=%f,%f&client_id=%@&client_secret=%@&categoryId=%@", [self.longitude doubleValue], [self.latitude doubleValue], self.clientID, self.clientSecret, self.categoryID];
      
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
    

    
    [self performSuccess];
}

- (void)cancel {
    [self.httpOperation cancel];
    [super cancel];
}

@end
