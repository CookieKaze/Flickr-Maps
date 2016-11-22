//
//  CollectionViewCell.h
//  MapsAndCats
//
//  Created by Erin Luu on 2016-11-22.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;
@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) Photo * photo;

-(void)setupCell;
@end
