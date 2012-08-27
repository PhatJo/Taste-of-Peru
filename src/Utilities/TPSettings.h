//
//  TPSettings.h
//  Taste of Peru
//
//  Created by Pietro Rea on 8/26/12.
//  Copyright (c) 2012 Pietro Rea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPSettings : NSObject

@property (strong, nonatomic) NSString* clientID;
@property (strong, nonatomic) NSString* clientSecret;
@property (strong, nonatomic) NSString* categoryID; //For Peruvian restaurants

+ (id)settings;

@end
