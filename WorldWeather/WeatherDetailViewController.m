//
//  WeatherDetailViewController.m
//  WorldWeather
//
//  Created by Rupak Sarker on 5/7/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

#import "WeatherDetailViewController.h"
#import "NSDictionary+Helper.h"
#import "UIImage+Helper.h"

@interface WeatherDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *temparatureInCelciusLabel;
@property (weak, nonatomic) IBOutlet UILabel *temparatureFeelsLikeCelciusLabel;
@property (weak, nonatomic) IBOutlet UILabel *temparatureInFahrenheitLabel;
@property (weak, nonatomic) IBOutlet UILabel *temparatureFeelsLikeFahrenheitLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *visibilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedInMilesLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedInKmphLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;


@end

@implementation WeatherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Weather Detail";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIImage loadFromURLString:[self.weatherData.weatherIconUrl weatherIconUrlString] callback:^(UIImage *image) {
        
        // Need to have better image quality to show images properly
        self.weatherImageView.image = image;
        self.weatherImageView.alpha = 0.4;
    }];
    [self updateView];
}

- (void)updateView {
    self.temparatureInCelciusLabel.text = [NSString stringWithFormat:@"%@ C", self.weatherData.tempInC];
    self.temparatureFeelsLikeCelciusLabel.text = [NSString stringWithFormat:@"%@ C", self.weatherData.feelsLikeC];
    self.temparatureInFahrenheitLabel.text = [NSString stringWithFormat:@"%@ F", self.weatherData.tempInF];
    self.temparatureFeelsLikeFahrenheitLabel.text = [NSString stringWithFormat:@"%@ F", self.weatherData.feelsLikeF];
    self.humidityLabel.text = [NSString stringWithFormat:@"%@ %@", self.weatherData.humidity, @"%"];
    self.pressureLabel.text = [NSString stringWithFormat:@"%@ Pa", self.weatherData.pressure];
    self.visibilityLabel.text = [NSString stringWithFormat:@"%@ SM", self.weatherData.visibility];
    self.weatherCodeLabel.text = [NSString stringWithFormat:@"%@", self.weatherData.weatherCode];
    self.weatherDescriptionLabel.text = [NSString stringWithFormat:@"%@", [self.weatherData.weatherDescription weatherDesc]];
    self.windSpeedInMilesLabel.text = [NSString stringWithFormat:@"%@", self.weatherData.windspeedMiles];
    self.windSpeedInKmphLabel.text = [NSString stringWithFormat:@"%@", self.weatherData.windspeedKmph];
    
    self.detailLabel.text = [NSString stringWithFormat:@"Showing Details For %@", self.zipCodeValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
