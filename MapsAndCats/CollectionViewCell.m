//
//  CollectionViewCell.m
//  MapsAndCats
//
//  Created by Erin Luu on 2016-11-22.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import "CollectionViewCell.h"
#import "Photo.h"
@interface CollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *photoLabel;
@property (weak, nonatomic) IBOutlet UIImageView * imageView;
@end

@implementation CollectionViewCell
-(void)setPhoto:(Photo *)photo {
    _photo = photo;
    [self setupCell];
}
-(void)setupCell {
    NSURL * imageUrl = [NSURL URLWithString: self.photo.url];
    //Convert image from data to UIImage
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *image = [UIImage imageWithData:imageData];
    self.imageView.image = image;
    
    //Check if there is a title
    if ([self.photo.title isEqualToString: @""]) {
        self.photoLabel.text = @"No Title";
    }else {
        self.photoLabel.text = self.photo.title;
    }
}
@end
