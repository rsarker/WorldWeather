//
//  WeatherDetailViewController.h
//  WorldWeather
//
//  Created by Rupak Sarker on 5/7/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherCondition.h"

@interface WeatherDetailViewController : UIViewController

- (void) updateWithWeatherData: (WeatherCondition *)weatherData;

@end
