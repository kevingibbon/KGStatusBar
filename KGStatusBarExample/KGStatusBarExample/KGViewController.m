//
//  KGViewController.m
//  KGStatusBarExample
//
//  Created by Kevin Gibbon on 3/3/13.
//  Copyright (c) 2013 Kevin Gibbon. All rights reserved.
//

#import "KGViewController.h"

@interface KGViewController ()

- (IBAction)successButtonPressed:(id)sender;
- (IBAction)errorButtonPressed:(id)sender;
- (IBAction)statusButtonPressed:(id)sender;
- (IBAction)dismissButtonPressed:(id)sender;

@end

@implementation KGViewController

- (void)viewDidLoad{[super viewDidLoad];}
- (void)didReceiveMemoryWarning{[super didReceiveMemoryWarning];}


- (IBAction)successButtonPressed:(id)sender {
    //Temporary message : only shows for few seconds.
    [KGStatusBar showSuccessWithStatus:@"Successfully synced"];
}
- (IBAction)errorButtonPressed:(id)sender {
    //Temporary message too
    [KGStatusBar showErrorWithStatus:@"Error syncing files"];
}
- (IBAction)statusButtonPressed:(id)sender {
    //A persistent message : will not dismiss until -(IBAction)dismissButtonPressed:(id)sender is called.
    [KGStatusBar showWithStatus:@"Loading..."];
}
- (IBAction)dismissButtonPressed:(id)sender {
    [KGStatusBar dismiss];
}
@end