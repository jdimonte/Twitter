//
//  DetailsViewController.m
//  twitter
//
//  Created by Jacqueline DiMonte on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface DetailsViewController ()

@property (strong, nonatomic) IBOutlet UILabel *detailName;
@property (strong, nonatomic) IBOutlet UILabel *detailUsername;
@property (strong, nonatomic) IBOutlet UIButton *InfoIcon;
@property (strong, nonatomic) IBOutlet UILabel *detailText;
@property (strong, nonatomic) IBOutlet UILabel *detailTime;
@property (strong, nonatomic) IBOutlet UIImageView *dotOne;
@property (strong, nonatomic) IBOutlet UILabel *detailDate;
@property (strong, nonatomic) IBOutlet UIImageView *dotTwo;
@property (strong, nonatomic) IBOutlet UILabel *detailPlatform;
@property (strong, nonatomic) IBOutlet UIButton *detailReply;
@property (strong, nonatomic) IBOutlet UIButton *detailRetweet;
@property (strong, nonatomic) IBOutlet UIButton *detailLike;
@property (strong, nonatomic) IBOutlet UIButton *detailShare;
@property (strong, nonatomic) IBOutlet UIImageView *detailImage;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *user = self.tweet.user;
    self.detailName.text = user.name;
    NSString *fullUsername = [@"@" stringByAppendingString:user.screenName];
    self.detailUsername.text = fullUsername;
    self.detailText.text = self.tweet.text;
    self.detailDate.text = self.tweet.createdAtString;
    
    self.detailImage.layer.cornerRadius =  self.detailImage.frame.size.width / 2;
    self.detailImage.clipsToBounds = true;
    
    self.dotOne.layer.cornerRadius =  self.dotOne.frame.size.width / 2;
    self.dotOne.clipsToBounds = true;
    self.dotTwo.layer.cornerRadius =  self.dotTwo.frame.size.width / 2;
    self.dotTwo.clipsToBounds = true;
    
    NSString *URLString = user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    [self.detailImage setImageWithURL:url];
    
    //update UI
    UIButton *btnRetweet = (UIButton *)self.detailRetweet;
    UIButton *btnLike = (UIButton *)self.detailLike;
    if(self.tweet.retweeted == YES){
        [btnRetweet setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
    }
    else{
        [btnRetweet setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    }
    if(self.tweet.favorited == YES){
        [btnLike setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
    }
    else{
        [btnLike setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)tappedRetweet:(id)sender {
    if(self.tweet.retweeted == YES){
        //retweet
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeting the following Tweet: %@", tweet.text);
            }
        }];
    } else {
        //unretweet
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeting the following Tweet: %@", tweet.text);
            }
        }];
    }
    UIButton *btn = (UIButton *)sender;

     if( [[btn imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"retweet-icon-green.png"]])
        {
           [btn setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
        }
     else
       {
           [btn setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
       }
}
- (IBAction)tappedFavorite:(id)sender {
    if(self.tweet.favorited == YES){
        //unfavorite
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    } else {
        //favorite
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    UIButton *btn = (UIButton *)sender;
     if( [[btn imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"favor-icon-red.png"]])
        {
           [btn setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
        }
     else
       {
           [btn setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
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

@end
