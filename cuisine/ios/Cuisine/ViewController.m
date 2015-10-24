//
//  ViewController.m
//  Cuisine
//
//  Created by Yeehan Chan on 9/30/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import "ViewController.h"
#import "ListView.h"
#import "loginPageViewController.h"
@interface ViewController ()
@property(strong,atomic) loginPageViewController *login;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.login = [[loginPageViewController alloc]init];
    [self presentViewController:self.login animated:NO completion:^{nil;}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
