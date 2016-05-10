//
//  NSDictionary+Helper.m
//  WorldWeather
//
//  Created by Rupak Sarker on 5/10/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

#import "NSDictionary+Helper.h"

@implementation NSDictionary (Helper)

- (NSString *)weatherDesc {
    return self[@"value"];
}
- (NSString *)weatherIconUrlString {
    NSString *urlString = self[@"value"];
    NSString *secureUrlString = [urlString stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
    return secureUrlString;
}

@end
