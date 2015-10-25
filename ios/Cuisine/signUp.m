//
//  signUp.m
//  Cuisine
//
//  Created by Yeehan Chan on 10/25/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import "signUp.h"

@interface signUp ()
@property(strong,nonatomic)UITextField *username;
@property(strong,nonatomic)UITextField *password;
@property(strong,nonatomic)UITextField *passwordConfirm;
@end

@implementation signUp

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScreen *screen = [UIScreen mainScreen];
    UIImage *img = [UIImage imageNamed:@"cover.png"];
    UIImageView *bgimg = [[UIImageView alloc]initWithFrame:CGRectMake(-200,0,screen.bounds.size.height*img.size.width/img.size.height, screen.bounds.size.height)];
    bgimg.image = img;
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x+20, self.view.bounds.origin.y+160, screen.bounds.size.width-40, 90)];
    [title setText:@"CUISINE"];
    [title setTextColor:[UIColor whiteColor]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setFont:[UIFont fontWithName:@"Chalkduster" size:70.0]];
    
    UIView *mask = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x+20, self.view.bounds.origin.y+260, screen.bounds.size.width-40, 300)];
    mask.backgroundColor = [UIColor whiteColor];
    mask.alpha = 0.7;
    
    self.username = [[UITextField alloc]initWithFrame:CGRectMake(mask.frame.origin.x +20, mask.frame.origin.y+40, mask.frame.size.width-40, 40)];
    self.username.placeholder = @"Username";
    self.username.borderStyle = UITextBorderStyleRoundedRect;
    self.username.textColor = [UIColor whiteColor];
    self.username.backgroundColor = [UIColor grayColor];
    self.username.alpha = 0.7;
    
    self.password = [[UITextField alloc]initWithFrame:CGRectMake(mask.frame.origin.x+20, mask.frame.origin.y+100, mask.frame.size.width-40, 40)];
    self.password.placeholder = @"Password";
    self.password.borderStyle = UITextBorderStyleRoundedRect;
    self.password.textColor = [UIColor whiteColor];
    self.password.backgroundColor = [UIColor grayColor];
    self.password.alpha = 0.7;
    self.password.secureTextEntry = YES;
    
    self.passwordConfirm = [[UITextField alloc]initWithFrame:CGRectMake(mask.frame.origin.x+20, mask.frame.origin.y+160, mask.frame.size.width-40, 40)];
    self.passwordConfirm.placeholder = @"Password Confirm";
    self.passwordConfirm.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordConfirm.textColor = [UIColor whiteColor];
    self.passwordConfirm.backgroundColor = [UIColor grayColor];
    self.passwordConfirm.alpha = 0.7;
    self.passwordConfirm.secureTextEntry = YES;
    
    UIButton *signUp= [[UIButton alloc]initWithFrame:CGRectMake(mask.frame.origin.x+40, mask.frame.origin.y+220, mask.frame.size.width-80, 50)];
    [[signUp layer]setBorderWidth:2.0];
    [[signUp layer]setBorderColor:[UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1.0].CGColor];
    [signUp setTitle:@"signUp" forState:UIControlStateNormal];
    [signUp.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:26.0]];
    [signUp setTitleColor:[UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [signUp addTarget:self action:@selector(signUpPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bgimg];
    [self.view addSubview:mask];
    [self.view addSubview:self.username];
    [self.view addSubview:self.password];
    [self.view addSubview:self.passwordConfirm];
    [self.view addSubview:title];
    [self.view addSubview:signUp];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpPressed{
    if(![self.password.text isEqualToString:self.passwordConfirm.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign Up Error!"
                                                        message:@"Confirm Password doesn't match!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://52.88.93.103/user"]];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                         self.username.text, @"user_name",
                         self.password.text, @"password",
                         nil];
        NSError *error;
        NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        [request setHTTPBody:postdata];
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    responseData = [[NSMutableData alloc] init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [responseData appendData:data];
    NSError *error = nil;
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSLog(@"%@",json);
    if([json objectForKey:@"type"] == @(YES)){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *tabBar = [sb instantiateViewControllerWithIdentifier:@"tabBar"];
        [self presentViewController:tabBar animated:NO completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign Up Error!"
                                                        message:[json objectForKey:@"data"]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

@end
