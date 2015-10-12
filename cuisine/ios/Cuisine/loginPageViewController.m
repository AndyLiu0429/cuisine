//
//  loginPageViewController.m
//  Cuisine
//
//  Created by Yeehan Chan on 10/8/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import "loginPageViewController.h"

@interface loginPageViewController ()

@end

@implementation loginPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:9001 forKey:@"HighScore"];
    [defaults synchronize];
    NSInteger theHighScore = [defaults integerForKey:@"HighScore"];
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
