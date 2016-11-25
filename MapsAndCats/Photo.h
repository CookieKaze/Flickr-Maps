//
//  Photo.h
//  MapsAndCats
//
//  Created by Erin Luu on 2016-11-22.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Photo : NSObject <MKAnnotation>

@property (nonatomic, readonly) NSString * photoID;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly) NSString * url;
@property (nonatomic, readonly) UIImage * image;
@property(nonatomic) CLLocationCoordinate2D coordinate;

-(instancetype)initWithID: (NSString*) photoID title: (NSString*) title url: (NSString*)url thumbnail: (NSString*)thumbnail;
-(void) setLat: (NSNumber*) locationLat andLong: (NSNumber*) locationLong;
@end
