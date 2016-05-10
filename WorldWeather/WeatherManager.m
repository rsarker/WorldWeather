//
//  WeatherManager.m
//  WorldWeather
//
//  Created by Rupak Sarker on 5/8/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

#import "WeatherManager.h"
#import "WeatherCondition.h"

NSString *const WorldWeatherOnlineAPIKey = @"ef388b00ee7541bb8f004348160905";
NSString *const WorldWeatherOnlineURLString = @"https://api.worldweatheronline.com/premium/v1/";

@interface WeatherManager ()

@property (nonatomic, strong) dispatch_queue_t dispatchQueue;

@end

@implementation WeatherManager

+ (WeatherManager *)sharedManager {
    static WeatherManager *_sharedWeatherManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedWeatherManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:WorldWeatherOnlineURLString]];
        
        _sharedWeatherManager.dispatchQueue = dispatch_queue_create("com.worldweather.networkqueue", 0);
    });
    
    return _sharedWeatherManager;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

- (void)updateWeatherForZipCode:(NSString *)zipCode {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // Seeting number of days value to constant 1
    parameters[@"num_of_days"] = @(1);
    
    parameters[@"q"] = zipCode;
    parameters[@"format"] = @"json";
    parameters[@"key"] = WorldWeatherOnlineAPIKey;
    
    dispatch_async(self.dispatchQueue, ^{
        [self GET:@"weather.ashx" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSError *weatherConditionError = nil;
            
            NSDictionary *conditionJsonDictionary = [responseObject[@"data"][@"current_condition"] firstObject];
                    
            WeatherCondition *condition = [MTLJSONAdapter modelOfClass:[WeatherCondition class] fromJSONDictionary:conditionJsonDictionary error:&weatherConditionError];

            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(weatherManager:didUpdateWithWeather:)]) {
                    [self.delegate weatherManager:self didUpdateWithWeather:condition];
                }
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(weatherManager:didFailWithError:)]) {
                    [self.delegate weatherManager:self didFailWithError:error];
                }
            });
        }];
    });
}

@end