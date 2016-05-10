//
//  WeatherManager.h
//  WorldWeather
//
//  Created by Rupak Sarker on 5/8/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@protocol WeatherManagerDelegate;

@interface WeatherManager : AFHTTPSessionManager

extern NSString *const WorldWeatherOnlineAPIKey;
extern NSString *const WorldWeatherOnlineURLString;

@property (nonatomic, weak) id <WeatherManagerDelegate>delegate;

+ (WeatherManager *)sharedManager;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)updateWeatherForZipCode:(NSString *)zipCode;

@end

@protocol WeatherManagerDelegate <NSObject>

- (void)weatherManager:(WeatherManager *)client didUpdateWithWeather:(id)weather;
- (void)weatherManager:(WeatherManager *)client didFailWithError:(NSError *)error;

@end
