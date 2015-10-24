//
//  ListCell.h
//  Cuisine
//
//  Created by Yeehan Chan on 9/30/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell
@property(atomic,strong) UIImageView *foodpic;
@property(atomic,strong) UIVisualEffectView *mask;
@property(atomic,strong) UIBlurEffect *blur;
@property(atomic,strong) UILabel *foodname;
@property(atomic,strong) UIImage *img;
@property(atomic,strong) NSString *fn;

- (void)populateImage:(UIImage *)i andFoodname:(NSString *)s;
@end
