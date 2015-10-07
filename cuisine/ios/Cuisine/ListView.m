//
//  ListView.m
//  Cuisine
//
//  Created by Yeehan Chan on 9/30/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import "ListView.h"
#import "ListCell.h"
#import <MapKit/MapKit.h>
@interface ListView ()

@end

@implementation ListView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" ];
    
    // Configure the cell...
    if(cell == nil){
        cell = [[ListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    UIImageView *foodpic =  [[UIImageView alloc]initWithFrame:CGRectMake(cell.bounds.origin.x, cell.bounds.origin.y, self.view.frame.size.width, 250)];
    foodpic.image = [UIImage imageNamed:@"food.png"];
    UIVisualEffectView *mask = [[UIVisualEffectView alloc]initWithFrame:CGRectMake(cell.bounds.origin.x, cell.bounds.size.height-90, self.view.frame.size.width, 90)];
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    mask.effect = blur;mask.alpha=0.2;
    UILabel *foodname = [[UILabel alloc]initWithFrame:CGRectMake(cell.bounds.origin.x, cell.bounds.size.height-90, self.view.frame.size.width, 90)];
    foodname.text = @"Sushi";
    [foodname setTextAlignment:NSTextAlignmentCenter];
//    foodname.textAlignment = NSTextAlignmentCenter;
    [foodname setTextColor:[UIColor whiteColor]];
//    foodname.textColor = [UIColor whiteColor];
    [foodname setFont:[UIFont fontWithName:@"Arial" size:28]];
//    foodname.font = [UIFont boldS];
    [foodpic addSubview:mask];
    [cell addSubview:foodpic];
    [cell addSubview:foodname];
//    [cell addSubview:mask];
//    cell.accessoryView = nil;
//    cell.accessoryType = UITableViewCellAccessoryNone;
//    NSLog(@"the content width:%1.0f",cell.imageView.frame.size.width);
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"food.png"]];
   
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
//    UINavigationController *nav = [[UINavigationController alloc]init];
    if(indexPath.row == 0){
        UIViewController *details = [[UIViewController alloc] init];
        details.view.backgroundColor = [UIColor whiteColor];
        CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
        UIImageView *foodpic =  [[UIImageView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+statusBarSize.height, self.view.frame.size.width, 250)];
        foodpic.image = [UIImage imageNamed:@"food.png"];
        [details.view addSubview:foodpic];
        [self.navigationController pushViewController:details animated:YES];
        UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(0, foodpic.frame.origin.y+foodpic.frame.size.height, self.view.frame.size.width, 50)];
        [address setText:@"111,8Ave,14th street"];
       [address setTextAlignment:NSTextAlignmentCenter];
        [address setFont:[UIFont fontWithName:@"Arial" size:18]];
        MKMapView *map = [[MKMapView alloc]initWithFrame:CGRectMake(0,address.frame.origin.y+address.frame.size.height,self.view.frame.size.width, 100)];
        [details.view addSubview:address];
        [details.view addSubview:map];
//        NSLog(@"statusbar and nav %f,picture origin %f, picture size %f",self.navigationController.navigationBar.frame.size.height+statusBarSize.height,foodpic.frame.origin.y,foodpic.frame.size.height);
    }
//    [self.navigationController.view addSubview:foodpic];

     // ...
     // Pass the selected object to the new view controller.
//    [nav pushViewController:detail animated:YES];
//     [nav pushViewController:detailViewController animated:YES];
    
    //    NSLog(@"index path: %@", indexPath);
    
    //Dismiss the view controller (which was presented modally) if the user taps on the 3rd row in the 2nd section.
//    if ( (indexPath.section == 1) && (indexPath.row == 2) ) {
//        [self dismissViewControllerAnimated:YES completion:^{
//            NSLog(@"It has been dismissed");
//        }];
    
    
    /**    //Here is a demonstration of using NSUserDefaults for persistent storage.
     //Note that NSUserDefaults can only contain certain data types. It is more restrictive than what can be put in a generic NSDictionary as a value, and even those cannot have ints as values. That's why we use NSNumber here.
     NSNumber *numberOfTimes = [[NSUserDefaults standardUserDefaults] objectForKey:@"number of times"];
     
     //The first time we pull this from NSUserDefaults numberOfTimes will be nil, so here we set it to 0 so it's an NSNumber one way or the other
     if (numberOfTimes == nil) {
     numberOfTimes = [NSNumber numberWithInt:0];
     }
     
     //need to extract the int from the NSNumber to be able to do arithmetic with it
     int n = [numberOfTimes integerValue] + 1;// add one to the count
     numberOfTimes = [NSNumber numberWithInt:n];// wrap it in an NSNumber
     
     //set the new NSNumber in the user defaults
     [[NSUserDefaults standardUserDefaults] setObject:numberOfTimes forKey:@"number of times"];
     NSLog(@"number of times: %@", numberOfTimes);
     
     //In order to appreciate the persistence of the persistent storage you should stop the app after running, then run the app directly in the device/simulator not via XCode, select some rows, and then fully quit the app (double tapping/clicking on the home button on the device/simulator), opening up again, selecting more rows, and then finally running the app with XCode again and then selecting some more rows. You will see that the counts increased for each time selected those cells.
     //Also note that the app crashes while being run in XCode, the user defaults get reset to what they were prior to running the application that time.
     **/
    
    //Below is a demonstration of code for showing an alert view. I did not show in class how to have code executed in response to the buttons of the UIAlertView being shown.
//    NSArray *key = [self.targetData allKeys];
//    if(indexPath.section == 0){
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Selection"
//                                                            message:[NSString stringWithFormat:@"Item: %@, Detail: %@",key[indexPath.row],[self.targetData objectForKey: key[indexPath.row]]]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Okay"
 //                                                 otherButtonTitles:nil];
 //       [alertView show];
        
//    }
//    else{
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Selection"
//                                                            message:[NSString stringWithFormat:@"Item: IOS assignment, Detail: try really hard"]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Okay"
//                                                  otherButtonTitles:nil];
//        [alertView show];

//    }
    
}


@end
