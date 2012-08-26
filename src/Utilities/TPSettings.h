//
//  TPSettings.h
//  Taste of Peru
//
//  Created by Pietro Rea on 8/26/12.
//  Copyright (c) 2012 Pietro Rea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPSettings : NSObject

@property (strong, nonatomic) NSString* cliendID;
@property (strong, nonatomic) NSString* clientSecret;

+ (id)settings;

@end
