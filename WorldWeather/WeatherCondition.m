//
//  WeatherCondition.m
//  WorldWeather
//
//  Created by Rupak Sarker on 5/7/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

#import "WeatherCondition.h"

@implementation WeatherCondition

//+ (NSDictionary *)imageMap {
//    static NSDictionary *_imageMap = nil;
//    if (! _imageMap) {
//        _imageMap = @{
//                      @"01d" : @"weather-clear",
//                      @"02d" : @"weather-few",
//                      @"03d" : @"weather-few",
//                      @"04d" : @"weather-broken",
//                      @"09d" : @"weather-shower",
//                      @"10d" : @"weather-rain",
//                      @"11d" : @"weather-tstorm",
//                      @"13d" : @"weather-snow",
//                      @"50d" : @"weather-mist",
//                      @"01n" : @"weather-moon",
//                      @"02n" : @"weather-few-night",
//                      @"03n" : @"weather-few-night",
//                      @"04n" : @"weather-broken",
//                      @"09n" : @"weather-shower",
//                      @"10n" : @"weather-rain-night",
//                      @"11n" : @"weather-tstorm",
//                      @"13n" : @"weather-snow",
//                      @"50n" : @"weather-mist",
//                      };
//    }
//    return _imageMap;
//}
//
//- (NSString *)imageName {
//    return [WeatherCondition imageMap][self.icon];
//}

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

//#pragma mark - Date Transformer Helper Methods
//
//+ (NSValueTransformer *)dateJSONTransformer {
//    return  [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
//        return [NSDate dateWithTimeIntervalSince1970:value.floatValue];
//    } reverseBlock:^id(NSDate *value, BOOL *success, NSError *__autoreleasing *error) {
//        return [NSString stringWithFormat:@"%f",[value timeIntervalSince1970]];
//    }];
//}
//
//+ (NSValueTransformer *)sunriseJSONTransformer {
//    return [self dateJSONTransformer];
//}
//
//+ (NSValueTransformer *)sunsetJSONTransformer {
//    return [self dateJSONTransformer];
//}

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
