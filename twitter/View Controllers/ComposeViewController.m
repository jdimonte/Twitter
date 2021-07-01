//
//  ComposeViewController.m
//  twitter
//
//  Created by Jacqueline DiMonte on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textBox;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)closeTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)tweetTapped:(UIBarButtonItem *)sender {
    //make API call and post
    NSString *s = self.textBox.text;
    [[APIManager shared] postStatusWithText:(s) completion:^(Tweet *t, NSError *error) {
        if(error){
                NSLog(@"Error composing Tweet: %@", error.localizedDescription);
            }
            else{
                [self.delegate didTweet:t];
                NSLog(@"Compose Tweet Success!");
            }
    }];
    
    [self dismissViewControllerAnimated:true completion:nil];
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
