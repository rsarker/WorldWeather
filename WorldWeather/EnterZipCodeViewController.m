//
//  EnterZipCodeViewController.m
//  WorldWeather
//
//  Created by Rupak Sarker on 5/7/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

#import "EnterZipCodeViewController.h"
#import "WeatherDetailViewController.h"
#import "WeatherManager.h"
#import "WeatherCondition.h"

@interface EnterZipCodeViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, WeatherManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *zipCodeList;
@property (weak, nonatomic) IBOutlet UITextField *enterZipCodeTextField;

@property (nonatomic, strong) WeatherCondition *condition;

@end

@implementation EnterZipCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.zipCodeList.dataSource = self;
    self.zipCodeList.delegate = self;
    
    [WeatherManager sharedManager].delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.zipCodeList dequeueReusableCellWithIdentifier:@"ZipCodeCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ZipCodeCell"];
    }
    
    cell.textLabel.text = @"Austin";
    cell.detailTextLabel.text = @"78759";
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WeatherDetailViewController *detailController = [storyboard instantiateViewControllerWithIdentifier:@"WeatherDetailController"];
    [self.navigationController pushViewController:detailController animated:YES];
}

- (IBAction)searchButtonTapped:(UIButton *)sender {
   [[WeatherManager sharedManager] updateWeatherForZipCode:@"78759"];
}

#pragma mark - Weather Manager Delegate Methods

- (void)weatherManager:(WeatherManager *)client didUpdateWithWeather:(id)weather {
    self.condition = (WeatherCondition *)weather;
}

- (void)weatherManager:(WeatherManager *)client didFailWithError:(NSError *)error {
    
}

@end
