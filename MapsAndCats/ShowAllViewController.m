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

@interface ShowAllViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ShowAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView addAnnotations:self.photos];
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(Photo*)annotation {
    MKAnnotationView * view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"withImage"];
    view.image = annotation.image;
    return view;
}

@end
