//
//  Photo.m
//  MapsAndCats
//
//  Created by Erin Luu on 2016-11-22.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import "Photo.h"

@implementation Photo
-(instancetype)initWithID: (NSString*) photoID title: (NSString*) title url: (NSString*)url {
    self = [super init];
    if (self) {
        _photoID = photoID;
        _title = title;
        _url = url;
    }
    return self;
}

-(void) setLat: (NSNumber*) locationLat andLong: (NSNumber*) locationLong {
    self.coordinate = CLLocationCoordinate2DMake([locationLat doubleValue], [locationLong doubleValue]);
}
@end