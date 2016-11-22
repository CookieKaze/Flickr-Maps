//
//  SearchViewController.h
//  MapsAndCats
//
//  Created by Erin Luu on 2016-11-22.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@protocol searchViewDelegate <NSObject>
- (void) updateImageCollectionWithTag: (NSString*) searchTag andLocation: (CLLocationCoordinate2D) coordinate;
@end

@interface SearchViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) id<searchViewDelegate> delegate;
@end
