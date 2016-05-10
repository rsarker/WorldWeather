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
@property (nonatomic, strong) NSMutableArray *searchArray;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSString *selectedZipCode;

@end

@implementation EnterZipCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Weather Search";
    self.zipCodeList.dataSource = self;
    self.zipCodeList.delegate = self;
    
    [WeatherManager sharedManager].delegate = self;
    self.enterZipCodeTextField.delegate = self;
    
    self.searchArray = [[NSMutableArray alloc] initWithObjects:@"78759", @"10001", @"95814", nil];
    
    [self drawTableFooterView];
    [self drawTableHeaderView];
}

#pragma mark - Table Header and Footer view helper methods

- (void)drawTableFooterView {
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150.0)];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"weather"] drawInRect:footerView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    footerView.backgroundColor = [UIColor colorWithPatternImage:image];
    self.zipCodeList.tableFooterView = footerView;
}

- (void)drawTableHeaderView {
    CGFloat offset = 10.0;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 25.0)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(offset, 0, headerView.bounds.size.width - offset, headerView.bounds.size.height)];
    titleLabel.text = @"Zip Code List";
    headerView.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:titleLabel];
    self.zipCodeList.tableHeaderView = headerView;
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.zipCodeList dequeueReusableCellWithIdentifier:@"ZipCodeCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ZipCodeCell"];
    }
    
    // TODO: The API for some reason not returning City name. Need to update textLabel with City name.
    cell.textLabel.text = @"";
    cell.detailTextLabel.text = [self.searchArray objectAtIndex:indexPath.row];
    
    return  cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.searchArray removeObjectAtIndex:indexPath.row];
        [self.zipCodeList reloadData];
    }
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self showActivityIndicator];
    UITableViewCell *selectedCell = [self.zipCodeList cellForRowAtIndexPath:indexPath];
    self.selectedZipCode = selectedCell.detailTextLabel.text;
    [[WeatherManager sharedManager] updateWeatherForZipCode:selectedCell.detailTextLabel.text];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
}

#pragma mark - Button Action

- (IBAction)searchButtonTapped:(UIButton *)sender {
    [self.enterZipCodeTextField resignFirstResponder];
    NSString *zipCode = self.enterZipCodeTextField.text;
    self.enterZipCodeTextField.text = @"";
    if (!zipCode || [zipCode isEqualToString:@""]) {
        [self showAlertControllerWithTitle:@"Really!!" andMessage:@"Please Enter valid zip code"];
    } else {
        [self showActivityIndicator];
        if (![self.searchArray containsObject:zipCode]) {
            [self.searchArray addObject:zipCode];
        }
        self.selectedZipCode = zipCode;
        [[WeatherManager sharedManager] updateWeatherForZipCode:zipCode];
    }
}

#pragma mark - Activity Indicator helper methods

- (void)showActivityIndicator {
    if (!self.activityIndicator) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        self.activityIndicator.center = self.view.center;
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        self.activityIndicator.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:self.activityIndicator];
        [self.activityIndicator startAnimating];
    }
}

- (void)hideActivityIndicator {
    if (self.activityIndicator) {
        [self.activityIndicator stopAnimating];
        [self.activityIndicator removeFromSuperview];
        self.activityIndicator = nil;
    }
}

#pragma mark - Weather Manager Delegate Methods

- (void)weatherManager:(WeatherManager *)client didUpdateWithWeather:(id)weather {
    [self hideActivityIndicator];
    
    self.condition = (WeatherCondition *)weather;
    [self.zipCodeList reloadData];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WeatherDetailViewController *detailController = [storyboard instantiateViewControllerWithIdentifier:@"WeatherDetailController"];
    detailController.weatherData = self.condition;
    detailController.zipCodeValue = self.selectedZipCode;
    [self.navigationController pushViewController:detailController animated:YES];
}

- (void)weatherManager:(WeatherManager *)client didFailWithError:(NSError *)error {
    [self hideActivityIndicator];
    
    [self showAlertControllerWithTitle:@"ERROR!" andMessage:@"OOOPSSS, error occurred while fetching data. Please try again."];
}

#pragma mark - Show Alert helper methods

- (void)showAlertControllerWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
