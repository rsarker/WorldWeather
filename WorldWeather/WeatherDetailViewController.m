//
//  WeatherDetailViewController.m
//  WorldWeather
//
//  Created by Rupak Sarker on 5/7/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

#import "WeatherDetailViewController.h"

@interface WeatherDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *temparatureLabel;

@end

@implementation WeatherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateWithWeatherData:(WeatherCondition *)weatherData {
    self.temparatureLabel.text = weatherData.tempInC;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
