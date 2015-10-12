//
//  detailPage.h
//  Cuisine
//
//  Created by Yeehan Chan on 10/7/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface detailPage : UIViewController
@property(atomic,strong) UIImageView *foodpic;
@property(atomic,strong) UILabel *address;
@property(atomic,strong) MKMapView *map;

- (void)populateImage:(UIImage *)img andAddress:(NSString *)addr andNavHeight:(int)h;
-(void)cleanCell;
@end
