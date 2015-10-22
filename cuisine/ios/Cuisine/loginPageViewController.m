//
//  loginPageViewController.m
//  Cuisine
//
//  Created by Yeehan Chan on 10/8/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import "loginPageViewController.h"
#import "myTabBarController.h"
#import "ListView.h"
@interface loginPageViewController ()
@property(strong,atomic)myTabBarController *tab;
@property(strong,atomic)ListView *list;
@end

@implementation loginPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setInteger:9001 forKey:@"HighScore"];
//    [defaults synchronize];
//    NSInteger theHighScore = [defaults integerForKey:@"HighScore"];
    UIScreen *screen = [UIScreen mainScreen];
    UIImage *img = [UIImage imageNamed:@"cover.png"];
    UIImageView *bgimg = [[UIImageView alloc]initWithFrame:CGRectMake(-200,0,screen.bounds.size.height*img.size.width/img.size.height, screen.bounds.size.height)];
    bgimg.image = img;
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x+20, self.view.bounds.origin.y+160, screen.bounds.size.width-40, 90)];
    [title setText:@"CUISINE"];
    [title setTextColor:[UIColor whiteColor]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setFont:[UIFont fontWithName:@"Chalkduster" size:70.0]];
    
    UIView *mask = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x+20, self.view.bounds.origin.y+260, screen.bounds.size.width-40, 260)];
    mask.backgroundColor = [UIColor whiteColor];
    mask.alpha = 0.7;
    
    UITextField *username = [[UITextField alloc]initWithFrame:CGRectMake(mask.frame.origin.x +20, mask.frame.origin.y+40, mask.frame.size.width-40, 40)];
    username.placeholder = @"Username";
    username.borderStyle = UITextBorderStyleRoundedRect;
    username.textColor = [UIColor whiteColor];
    username.backgroundColor = [UIColor grayColor];
    username.alpha = 0.7;
    
    UITextField *password = [[UITextField alloc]initWithFrame:CGRectMake(mask.frame.origin.x+20, mask.frame.origin.y+100, mask.frame.size.width-40, 40)];
    password.placeholder = @"Password";
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.textColor = [UIColor whiteColor];
    password.backgroundColor = [UIColor grayColor];
    password.alpha = 0.7;
    
    UIButton *login= [[UIButton alloc]initWithFrame:CGRectMake(mask.frame.origin.x+40, mask.frame.origin.y+160, mask.frame.size.width-80, 50)];
    [[login layer]setBorderWidth:2.0];
    [[login layer]setBorderColor:[UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1.0].CGColor];
//    login.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:151 green:151 blue:151 alpha:1]);
    [login setTitle:@"Login" forState:UIControlStateNormal];
    [[login titleLabel]setFont:[UIFont fontWithName:@"Chalkduster" size:26.0]];
    [login setTitleColor:[UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1.0] forState:UIControlStateNormal];
//    login.backgroundColor = [UIColor greenColor];
    [login addTarget:self action:@selector(loginPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgimg];
    [self.view addSubview:mask];
    [self.view addSubview:username];
    [self.view addSubview:password];
    [self.view addSubview:login];
    [self.view addSubview:title];

}
- (void)loginPressed{
//    self.tab = [[myTabBarController alloc]init];
//    self.list = [[ListView alloc]init];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabBar = [sb instantiateViewControllerWithIdentifier:@"tabBar"];
    [self presentViewController:tabBar animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
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
