//
//  SearchViewController.m
//  MapsAndCats
//
//  Created by Erin Luu on 2016-11-22.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import "SearchViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@property (weak, nonatomic) IBOutlet UISwitch *locationSwitch;
@property (nonatomic) CLLocationManager * locationManager;
@property (nonatomic) CLLocation * location;
@property (weak, nonatomic) IBOutlet UIView *locationSwitchView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.locationSwitchView setHidden:YES];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus] ;
    if (status == kCLAuthorizationStatusDenied) {
        NSLog(@"Permission denied");
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchBar resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)onSearchButtonTapped:(UIButton *)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(0, 0);
    if ([self.locationSwitch isOn] == YES) {
        [self.locationManager requestLocation];
        coordinate = self.locationManager.location.coordinate;
    }
    [self.delegate updateImageCollectionWithTag:self.searchBar.text andLocation:coordinate];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"%@", error.localizedDescription);
    
}

@end
