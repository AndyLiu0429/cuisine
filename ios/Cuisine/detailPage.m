//
//  detailPage.m
//  Cuisine
//
//  Created by Yeehan Chan on 10/7/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import "detailPage.h"
#import "mapViewController.h"
@interface detailPage ()
@property(atomic,weak) NSString* foodtitle;
@property(atomic,weak) NSString* fooddiscription;
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
    self.mask.effect = self.blur;self.mask.alpha =0.5;
//    [self.foodpic addSubview:self.mask];
    UIButton *location = [[UIButton alloc]initWithFrame:CGRectMake(0, self.mask.frame.origin.y, self.mask.frame.size.width/3, 90)];
//    location.backgroundColor = [UIColor whiteColor];
    UIImage *localIcon = [UIImage imageNamed:@"location"];
    UIImageView *localFrame = [[UIImageView alloc]initWithImage:localIcon];
    [localFrame setFrame:CGRectMake((location.bounds.size.width-localFrame.bounds.size.width)/2, 15,localFrame.frame.size.width,localFrame.frame.size.height)];
//    localFrame.alpha = 1.0;
    UILabel *distance = [[UILabel alloc]initWithFrame:CGRectMake(location.bounds.origin.x, localFrame.bounds.origin.y+localFrame.bounds.size.height+20, location.bounds.size.width, 20)];
    [distance setText:@"1.2 miles"];
    [distance setTextAlignment:NSTextAlignmentCenter];
    [distance setFont:[UIFont fontWithName:@"DIN Alternate" size:14]];
    [distance setTextColor:[UIColor whiteColor]];
    [location addSubview:localFrame];
    [location addSubview:distance];
    
    UIButton *like = [[UIButton alloc]initWithFrame:CGRectMake(self.mask.frame.size.width/3, self.mask.frame.origin.y, self.mask.frame.size.width/3, 90)];
//    like.backgroundColor = [UIColor whiteColor];
    UIImage *likeIcon = [UIImage imageNamed:@"like"];
    UIImageView *likeFrame = [[UIImageView alloc]initWithImage:likeIcon];
    [likeFrame setFrame:CGRectMake((like.bounds.size.width-likeFrame.bounds.size.width)/2, 15,likeFrame.bounds.size.width,likeFrame.bounds.size.height)];
    UILabel *likeCounts = [[UILabel alloc]initWithFrame:CGRectMake(like.bounds.origin.x, likeFrame.bounds.origin.y+likeFrame.bounds.size.height+20, like.bounds.size.width, 20)];
    [likeCounts setText:@"100"];
    [likeCounts setTextAlignment:NSTextAlignmentCenter];
    [likeCounts setFont:[UIFont fontWithName:@"DIN Alternate" size:14]];
    [likeCounts setTextColor:[UIColor whiteColor]];

    [like addSubview:likeFrame];
    [like addSubview:likeCounts];
    
    UIButton *coin = [[UIButton alloc]initWithFrame:CGRectMake(self.mask.frame.size.width*2/3, self.mask.frame.origin.y, self.mask.frame.size.width/3, 90)];
//    coin.backgroundColor = [UIColor whiteColor];
    UIImage *coinIcon = [UIImage imageNamed:@"coin"];
    UIImageView *coinFrame = [[UIImageView alloc]initWithImage:coinIcon];
    [coinFrame setFrame:CGRectMake((coin.bounds.size.width-coinFrame.bounds.size.width)/2, 15,coinFrame.bounds.size.width,coinFrame.bounds.size.height)];
    UILabel *coinCounts = [[UILabel alloc]initWithFrame:CGRectMake(coin.bounds.origin.x, coinFrame.bounds.origin.y+coinFrame.bounds.size.height+20, coin.bounds.size.width, 20)];
    [coinCounts setText:@"$$"];
    [coinCounts setTextAlignment:NSTextAlignmentCenter];
    [coinCounts setFont:[UIFont fontWithName:@"DIN Alternate" size:14]];
    [coinCounts setTextColor:[UIColor whiteColor]];
    [coin addSubview:coinFrame];
    [coin addSubview:coinCounts];
    
//    [self.mask addSubview:location];
//    [self.mask addSubview:like];
//    [self.mask addSubview:coin];

    
    self.foodTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,self.foodpic.frame.origin.y+self.foodpic.frame.size.height,self.view.frame.size.width, 40)];
    self.foodTitle.text = self.foodtitle;
    [self.foodTitle setTextAlignment:NSTextAlignmentLeft];
    [self.foodTitle setFont:[UIFont fontWithName:@"Helvetica Neue" size:30]];
    
    self.foodDiscription = [[UITextView alloc]initWithFrame:CGRectMake(0, self.foodTitle.frame.origin.y+self.foodTitle.frame.size.height,self.view.bounds.size.width,90)];
//    self.foodDiscription.backgroundColor = [UIColor redColor];
    [self.foodDiscription setText:self.fooddiscription];
    [self.foodDiscription setTextAlignment:NSTextAlignmentLeft];
    [self.foodDiscription setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.foodDiscription.frame.size.height, self.foodDiscription.frame.size.width, 0.5f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:151/255 green:151/255 blue:151/255 alpha:1].CGColor;
    [self.foodDiscription.layer addSublayer:bottomBorder];    //[self.foodDiscription sizeToFit];
    
    self.map = [[MKMapView alloc]initWithFrame:CGRectMake(0,self.foodTitle.frame.origin.y+self.foodTitle.frame.size.height,self.view.frame.size.width, 100)];
    
    UIButton *review = [[UIButton alloc]initWithFrame:CGRectMake(25,self.view.bounds.size.height-120, 150, 50)];
//    review.backgroundColor = [UIColor blackColor];
    review.layer.borderWidth = 1.0f;
    review.layer.borderColor = [UIColor colorWithRed:151.0/255 green:151.0/255 blue:151.0/255 alpha:1].CGColor;
    [review setTitle:@"+REVIEW" forState:UIControlStateNormal];
    [review setTitleColor:[UIColor colorWithRed:151.0/255 green:151.0/255 blue:151.0/255 alpha:1] forState:UIControlStateNormal];
//    [[review titleLabel]setFont:[UIFont fontWithName:@"Helvetica Nune" size:20.0]];
    
    UIButton *gonow = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 25 - 150,self.view.bounds.size.height-120, 150, 50)];
    gonow.backgroundColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1.0];
    [gonow setTitle:@"GO NOW" forState:UIControlStateNormal];
    [gonow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [gonow addTarget:self action:@selector(directToMap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.foodpic];
    [self.view addSubview:self.foodTitle];
    [self.view addSubview:self.foodDiscription];
    [self.view addSubview:self.mask];
    [self.view addSubview:location];
    [self.view addSubview:like];
    [self.view addSubview:coin];
    [self.view addSubview:review];
    [self.view addSubview:gonow];

//    [self.view addSubview:self.map];
}
- (void)directToMap{
    //populate food address
    mapViewController *mapView = [[mapViewController alloc]init];
    [self.navigationController pushViewController:mapView animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)populateImage:(UIImage *)i andfoodTitle:(NSString *)a andfoodDiscription:(NSString *)b andNavHeight:(int)h{
    self.img = i;
    self.foodtitle = a;
    self.fooddiscription = b;
    navh = h;
//    NSLog(@"%@",self.img);
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
