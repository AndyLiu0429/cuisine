//
//  detailPage.m
//  Cuisine
//
//  Created by Yeehan Chan on 10/7/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import "detailPage.h"
@interface detailPage ()
@property(atomic,weak) NSString* addr;
@property(atomic,strong) UIImage *img;
@property(atomic,strong) UIVisualEffectView *mask;
@property(atomic,strong) UIBlurEffect *blur;
@end
int navh;
@implementation detailPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    self.foodpic = [[UIImageView alloc]initWithFrame:CGRectMake(0,navh+statusBarSize.height,self.view.frame.size.width, 250)];
    self.foodpic.image = self.img;
    
    self.mask = [[UIVisualEffectView alloc]initWithFrame:CGRectMake(0,self.foodpic.frame.origin.y+self.foodpic.frame.size.height-90,self.view.frame.size.width, 90)];
//    self.mask = [[UIVisualEffectView alloc]init];
    self.blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.mask.effect = self.blur;self.mask.alpha=0.5;
//    [self.foodpic addSubview:self.mask];
    
    self.address = [[UILabel alloc] initWithFrame:CGRectMake(0,self.foodpic.frame.origin.y+self.foodpic.frame.size.height,self.view.frame.size.width, 50)];
    self.address.text = self.addr;
    self.map = [[MKMapView alloc]initWithFrame:CGRectMake(0,self.address.frame.origin.y+self.address.frame.size.height,self.view.frame.size.width, 100)];
    [self.view addSubview:self.foodpic];
    [self.view addSubview:self.address];
    [self.view addSubview:self.mask];

    [self.view addSubview:self.map];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)populateImage:(UIImage *)i andAddress:(NSString *)a andNavHeight:(int)h{
    self.img = i;
    self.addr = a;
    navh = h;
//    NSLog(@"%@",self.img);
}
- (void)cleanCell{
    self.img = NULL;
    self.addr = NULL;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
