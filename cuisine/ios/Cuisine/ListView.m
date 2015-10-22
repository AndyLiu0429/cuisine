//
//  ListView.m
//  Cuisine
//
//  Created by Yeehan Chan on 9/30/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import "ListView.h"
#import "ListCell.h"
#import "detailPage.h"
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
@interface ListView ()
//@property(atomic,strong) detailPage *details;
@property (strong, nonatomic) UISearchBar *searchBar;
@end

@implementation ListView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.

    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 40)];
    self.searchBar.showsCancelButton = NO; 
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    [self.tableView setContentOffset:CGPointMake(0, 40)];
    
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(userDidSwipeLeft:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    swipe.delegate = self;
    [self.tableView addGestureRecognizer:swipe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)userDidSwipeLeft: (UISwipeGestureRecognizer *)swipe{
        CGPoint location = [swipe locationInView:self.tableView];
        NSIndexPath *swipeCell = [self.tableView indexPathForRowAtPoint:location];
//    NSLog(@"%@",swipeCell);
        ListCell* cell = [self.tableView cellForRowAtIndexPath:swipeCell];
    cell.userInteractionEnabled = YES;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [UIView animateWithDuration:0.1f animations:^{
        cell.foodpic.frame = CGRectOffset(cell.foodpic.frame, -40, 0);
    }];
    //    NSLog(@"%@",cell.accessoryType);
//    NSLog(@"gotin");

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" ];
//    CGFloat navh = self.navigationController.navigationBar.frame.size.height;
//    cell.frame = CGRectMake(self.view.frame.origin.x,navh+self.view.frame.origin.y,self.view.frame.size.width,250);
    // Configure the cell...
    if(cell == nil){
        cell = [[ListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    if(indexPath.row == 0){
//        UIImage *img = [UIImage imageNamed:@"food.png"];
//        NSString *foodname = @"Sushi";
        [cell populateImage:[UIImage imageNamed:@"food.png"] andFoodname:@"swipe left"];
        [cell awakeFromNib];
    }
    if(indexPath.row == 1){
        [cell populateImage:[UIImage imageNamed:@"food1.png"] andFoodname:@"Don't know what is this"];
        [cell awakeFromNib];
    }
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
        detailPage *details = nil;
        if(!details){
            details = [[detailPage alloc] init];
            NSString *foodtitle = @"Here is Food Title";
            [details populateImage:[UIImage imageNamed:@"food.png"] andfoodTitle:foodtitle andfoodDiscription:@"fooddiscription fooddiscription fooddiscription fooddiscription fooddiscription fooddiscription fooddiscription fooddiscription fooddiscription fooddiscription fooddiscription" andNavHeight:self.navigationController.navigationBar.frame.size.height];
        }
        [self.navigationController pushViewController:details animated:NO];
    }
    if(indexPath.row == 1){
        detailPage *details = nil;
//        UIImage *img = [UIImage imageNamed:@"food1.png"];
//        NSString *addr = @"address2";
        //        NSLog(@"asdfd%@",addr);
        if(!details){
            details = [[detailPage alloc]init];
            [details populateImage:[UIImage imageNamed:@"food1.png"] andfoodTitle:@"Here is Food Title" andfoodDiscription:@"fooddiscription fooddiscription fooddiscription fooddiscription fooddiscription fooddiscription fooddiscription fooddiscription fooddiscription" andNavHeight:self.navigationController.navigationBar.frame.size.height];
        }
        [self.navigationController pushViewController:details animated:NO];
        NSLog(@"%ld",(long)indexPath.row);
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
        
}


@end
