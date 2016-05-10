//
//  WeatherCondition.m
//  WorldWeather
//
//  Created by Rupak Sarker on 5/7/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

#import "WeatherCondition.h"

@implementation WeatherCondition

#pragma mark - MTLJSONSerializing Protocol methods

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"feelsLikeC": @"FeelsLikeC",
             @"feelsLikeF": @"FeelsLikeF",
             @"humidity": @"humidity",
             @"pressure": @"pressure",
             @"tempInC": @"temp_C",
             @"tempInF": @"temp_F",
             @"visibility": @"visibility",
             @"weatherCode": @"weatherCode",
             @"weatherDescription": @"weatherDesc",
             @"weatherIconUrl": @"weatherIconUrl",
             @"windspeedMiles": @"windspeedMiles",
             @"windspeedKmph": @"windspeedKmph"
             };
}

#pragma mark - NSArray<->NSString Conversion Helper Methods

+ (NSValueTransformer *)weatherDescriptionJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *values, BOOL *success, NSError *__autoreleasing *error) {
        return [values firstObject];
    } reverseBlock:^id(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        return @[value];
    }];
}

+ (NSValueTransformer *)weatherIconUrlJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *values, BOOL *success, NSError *__autoreleasing *error) {
        return [values firstObject];
    } reverseBlock:^id(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        return @[value];
    }];
}

+ (NSValueTransformer *)conditionJSONTransformer {
    return [self weatherDescriptionJSONTransformer];
}

+ (NSValueTransformer *)iconJSONTransformer {
    return [self weatherIconUrlJSONTransformer];
}

@end
