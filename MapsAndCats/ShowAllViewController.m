//
//  ShowAllViewController.m
//  MapsAndCats
//
//  Created by Erin Luu on 2016-11-25.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import "ShowAllViewController.h"
#import <MapKit/MapKit.h>
#import "Photo.h"

@interface ShowAllViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ShowAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.05f, 0.05f);
//    self.mapView.region = MKCoordinateRegionMake(photo.coordinate, span);
    [self.mapView addAnnotations:self.photos];
    
}


@end
