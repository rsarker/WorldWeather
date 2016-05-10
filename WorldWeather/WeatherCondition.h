//
//  WeatherCondition.h
//  WorldWeather
//
//  Created by Rupak Sarker on 5/7/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface WeatherCondition : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *feelsLikeC;
@property (nonatomic, strong) NSString *feelsLikeF;
@property (nonatomic, strong) NSString *humidity;
@property (nonatomic, strong) NSString *pressure;
@property (nonatomic, strong) NSString *tempInC;
@property (nonatomic, strong) NSString *tempInF;
@property (nonatomic, strong) NSString *visibility;
@property (nonatomic, strong) NSString *weatherCode;
@property (nonatomic, strong) NSDictionary *weatherDescription;
@property (nonatomic, strong) NSDictionary *weatherIconUrl;
@property (nonatomic, strong) NSString *windspeedMiles;
@property (nonatomic, strong) NSString *windspeedKmph;

@end
