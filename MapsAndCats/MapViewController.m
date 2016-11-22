//
//  MapViewController.m
//  MapsAndCats
//
//  Created by Erin Luu on 2016-11-22.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import "MapViewController.h"
#import "Photo.h"
#import <MapKit/MapKit.h>

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navTitle;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle.title = self.photo.title;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05f, 0.05f);
    self.mapView.region = MKCoordinateRegionMake(self.photo.coordinate, span);
    [self.mapView addAnnotation:self.photo];
}


@end
