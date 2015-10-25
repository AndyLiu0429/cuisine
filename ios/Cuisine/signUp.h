//
//  signUp.h
//  Cuisine
//
//  Created by Yeehan Chan on 10/25/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface signUp : UIViewController <NSURLConnectionDelegate>
{NSMutableData * responseData;}
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *signupbtn;
@end
