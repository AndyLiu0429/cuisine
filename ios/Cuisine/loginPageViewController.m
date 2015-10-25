//
//  loginPageViewController.m
//  Cuisine
//
//  Created by Yeehan Chan on 10/8/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import "loginPageViewController.h"
#import "signUp.h"
@interface loginPageViewController ()

@property(strong,nonatomic)UITextField *username;
@property(strong,nonatomic)UITextField *password;

@end

@implementation loginPageViewController

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
    
    UIView *mask = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x+20, self.view.bounds.origin.y+260, screen.bounds.size.width-40, 260)];
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
    
    UIButton *login= [[UIButton alloc]initWithFrame:CGRectMake(mask.frame.origin.x+40, mask.frame.origin.y+160, mask.frame.size.width-80, 50)];
    [[login layer]setBorderWidth:2.0];
    [[login layer]setBorderColor:[UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1.0].CGColor];
//    login.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:151 green:151 blue:151 alpha:1]);
    [login setTitle:@"Login" forState:UIControlStateNormal];
    [login.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:26.0]];
    [login setTitleColor:[UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1.0] forState:UIControlStateNormal];
//    login.backgroundColor = [UIColor greenColor];
    [login addTarget:self action:@selector(loginPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *signup = [[UIButton alloc]initWithFrame:CGRectMake(login.frame.origin.x+20,login.frame.origin.y+60,250,20)];
    [signup setTitle:@"Don't have an account?Sign up here!" forState:UIControlStateNormal];
    [signup.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [signup setTitleColor: [UIColor colorWithRed:151.0/255 green:151.0/255 blue:151.0/255 alpha:1] forState:UIControlStateNormal];
    
    [signup addTarget:self action:@selector(goSignUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgimg];
    [self.view addSubview:mask];
    [self.view addSubview:self.username];
    [self.view addSubview:self.password];
    [self.view addSubview:login];
    [self.view addSubview:title];
    [self.view addSubview:signup];
    
}
- (void)loginPressed{
    //create the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://52.88.93.103/authenticate"]];
    request.HTTPMethod=@"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                         self.username.text, @"user_name",
                         self.password.text, @"password",
                         nil];
    NSError *error;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
    [request setHTTPBody:postdata];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}
-(void)goSignUp{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    signUp *signuppage = [sb instantiateViewControllerWithIdentifier:@"signup"];
    [self presentViewController:signuppage animated:NO completion:nil];
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
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    responseData = [[NSMutableData alloc] init];
    NSLog(@"receive response");
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [responseData appendData:data];
    NSError *error = nil;
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSLog(@"%@",json);

   if([json objectForKey:@"type"] == @(YES)){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *tabBar = [sb instantiateViewControllerWithIdentifier:@"tabBar"];
        [self presentViewController:tabBar animated:NO completion:nil];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error!"
                                                        message:@"Incorrect username or password!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }

}
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
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
