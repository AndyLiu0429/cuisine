//
//  myTabBarController.m
//  Cuisine
//
//  Created by Yeehan Chan on 10/15/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import "myTabBarController.h"
#import "ListView.h"
@interface myTabBarController ()
@property(strong,atomic)ListView *list;
@end

@implementation myTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.list = [[ListView alloc]init];
    NSArray *tabViews = [NSArray arrayWithObjects:self.list, nil];
    [self setViewControllers:tabViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
