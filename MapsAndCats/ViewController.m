//
//  ViewController.m
//  MapsAndCats
//
//  Created by Erin Luu on 2016-11-22.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import "CollectionViewCell.h"
#import "MapViewController.h"
#import "SearchViewController.h"
#import "ShowAllViewController.h"
#import "Image+CoreDataClass.h"



@interface ViewController ()
@property (nonatomic) NSMutableArray * photoCollection;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) SearchViewController *searchView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoCollection = [[NSMutableArray alloc] init];
    [self setCollectionViewSpacing];
    
    
    NSURL * url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=83a51eb8204a6855817baba646a9a662&sort=relevance&has_geo=1&per_page=100&format=json&nojsoncallback=1&extras=url_m,url_sq&tags=cat"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask * task = [session
                                   dataTaskWithRequest:request
                                   completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                       if (error != nil) {
                                           NSLog(@"Something went wrong with the data task: %@", error.localizedDescription);
                                           return;
                                       }
                                       NSError * err = nil;
                                       NSDictionary * flickrData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
                                       if (err != nil) {
                                           NSLog(@"Something went wrong with the JSON: %@", err.localizedDescription);
                                           return;
                                       }
                                       
                                       NSArray * photos = flickrData[@"photos"][@"photo"];
                                       for (NSDictionary * photoInfo in photos){
                                           Photo * photo = [[Photo alloc] initWithID:photoInfo[@"id"] title:photoInfo[@"title"] url:photoInfo[@"url_m"] thumbnail: photoInfo[@"url_sq"]];
                                           [self getLocationData:photo];
                                           [self.photoCollection addObject:photo];
                                       }
                                       
                                       [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                           [self.collectionView reloadData];
                                       }];
                                   }];
    [task resume];
    
}

- (void) updateImageCollectionWithTag: (NSString*) searchTag andLocation: (CLLocationCoordinate2D) coordinate {
    if (searchTag) {
        NSString * lon = [NSString stringWithFormat:@"%f", coordinate.longitude];
        NSString * lat = [NSString stringWithFormat:@"%f", coordinate.latitude];
        NSURL * url;
        if ([lon isEqualToString:@"0.000000"] && [lat isEqualToString:@"0.000000"]) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=83a51eb8204a6855817baba646a9a662&sort=relevance&has_geo=1&per_page=100&format=json&nojsoncallback=1&extras=url_m&tags=%@", searchTag]];
        }else{
            url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=83a51eb8204a6855817baba646a9a662&sort=relevance&has_geo=1&per_page=100&format=json&nojsoncallback=1&extras=url_m&tags=%@&lat=%@&lon=%@", searchTag, lat, lon]];
            
        }
        searchTag = [searchTag stringByReplacingOccurrencesOfString:@" " withString:@""];
        self.photoCollection = [[NSMutableArray alloc] init];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        
        NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession * session = [NSURLSession sessionWithConfiguration:config];
        NSURLSessionDataTask * task = [session
                                       dataTaskWithRequest:request
                                       completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                           if (error != nil) {
                                               NSLog(@"Something went wrong with the data task: %@", error.localizedDescription);
                                               return;
                                           }
                                           NSError * err = nil;
                                           NSDictionary * flickrData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
                                           if (err != nil) {
                                               NSLog(@"Something went wrong with the JSON: %@", err.localizedDescription);
                                               return;
                                           }
                                           
                                           NSArray * photos = flickrData[@"photos"][@"photo"];
                                           for (NSDictionary * photoInfo in photos){
                                               Photo * photo = [[Photo alloc] initWithID:photoInfo[@"id"] title:photoInfo[@"title"] url:photoInfo[@"url_m"] thumbnail:photoInfo[@"url_sq"]];
                                               [self.photoCollection addObject:photo];
                                           }
                                           
                                           [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                               [self.collectionView reloadData];
                                           }];
                                       }];
        [task resume];
    }
}
-(void) getLocationData: (Photo *) photo {
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=83a51eb8204a6855817baba646a9a662&photo_id=%@&format=json&nojsoncallback=1", photo.photoID]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask * task = [session
                                   dataTaskWithRequest:request
                                   completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                       if (error != nil) {
                                           NSLog(@"Something went wrong with the data task: %@", error.localizedDescription);
                                           return;
                                       }
                                       NSError * err = nil;
                                       NSDictionary * flickrData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
                                       if (err != nil) {
                                           NSLog(@"Something went wrong with the JSON: %@", err.localizedDescription);
                                           return;
                                       }
                                       
                                       NSDictionary * locationInfo = flickrData[@"photo"][@"location"];
                                       [photo setLat:locationInfo[@"latitude"] andLong:locationInfo[@"longitude"]];
                                       
                    
                                   }];
    [task resume];
}

#pragma mark - Collection DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoCollection.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    Photo * currentPhoto =  self.photoCollection[indexPath.row];
    cell.photo = currentPhoto;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(collectionView.frame), (CGRectGetWidth(collectionView.frame)));
}

#pragma mark - Collection Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
        [self performSegueWithIdentifier:@"mapView" sender:self.photoCollection[indexPath.row]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(Photo*)sender {
    if ([segue.identifier isEqualToString: @"mapView"]) {
        MapViewController * mvc = [segue destinationViewController];
        mvc.photo = sender;
    }
    if ([segue.identifier isEqualToString:@"searchView"]) {
        self.searchView = [segue destinationViewController];
        self.searchView.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"showAll"]) {
        ShowAllViewController * showAllView = [segue destinationViewController];
        showAllView.photos = [self.photoCollection copy];
    }
}

-(void) setCollectionViewSpacing {
    //Remove all spacing from flow layout
    UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    self.collectionView.collectionViewLayout = flowLayout;
}

@end
