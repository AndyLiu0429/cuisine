//
//  ListCell.m
//  Cuisine
//
//  Created by Yeehan Chan on 9/30/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell
- (void)awakeFromNib {
    // Initialization code
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;

    self.foodpic = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, screenWidth, 250)];
    self.foodpic.image = self.img;
    
    
    self.mask = [[UIVisualEffectView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.size.height-90, self.frame.size.width, 90)];
    self.blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.mask.effect = self.blur;self.mask.alpha = 0.2;
    
    self.foodname =[[UILabel alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.size.height-90, screenWidth, 90)];
    
    self.foodname.text = self.fn;
//    [foodname setTextAlignment:NSTextAlignmentCenter];
    //    foodname.textAlignment = NSTextAlignmentCenter;
    //    [foodname setTextColor:[UIColor whiteColor]];
    //    foodname.textColor = [UIColor whiteColor];
    //    [foodname setFont:[UIFont fontWithName:@"Arial" size:28]];
    //    foodname.font = [UIFont boldS];
    [self.foodname setTextAlignment:NSTextAlignmentCenter];
    [self.foodname setFont:[UIFont fontWithName:@"Arial" size:28]];
    [self.foodname setTextColor:[UIColor whiteColor]];
    
    [self addSubview:self.foodpic];
    [self addSubview:self.mask];
    [self addSubview:self.foodname];
}
- (void)setSelected:(BOOL)selected anim:
ated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)populateImage:(UIImage *)i andFoodname:(NSString *)s{
    self.img = i;
    self.fn = s;
//    NSLog(@"%@",self.img);
}


@end
