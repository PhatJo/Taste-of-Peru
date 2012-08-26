//
//  TPSettings.m
//  Taste of Peru
//
//  Created by Pietro Rea on 8/26/12.
//  Copyright (c) 2012 Pietro Rea. All rights reserved.
//

#import "TPSettings.h"

@implementation TPSettings

static TPSettings* _settings;

+ (void)initialize {
    _settings = [[TPSettings alloc] init];
    
}

+ (id)settings {
    return _settings;
}

+ (NSString*)clientID {
    return @"AILGUKJJVVF1ZYI3C2TFCKZIOCYYBA1KYCTTRVG0KQTYG3ND";
}

+ (NSString*)cliendSecret {
    return @"IYPUXQCYRIBEMHKBVITTFBBQKBVSBPWYFH1XQKAMW0XXPQX1";
}

@end
