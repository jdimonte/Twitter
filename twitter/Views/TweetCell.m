//
//  TweetCell.m
//  twitter
//
//  Created by Jacqueline DiMonte on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapFavorite:(id)sender {
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
           // other statements
            self.likeCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
            self.likeCount.textColor =[UIColor grayColor];
        }
     else
       {
           [btn setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
           // other statements
           self.likeCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
           self.likeCount.textColor =[UIColor redColor];
       }
    [self refreshData];
}
- (IBAction)didTapRetweet:(id)sender {
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
           // other statements
            self.retweetCount.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
            self.likeCount.textColor =[UIColor grayColor];
        }
     else
       {
           [btn setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
           // other statements
           self.retweetCount.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
           self.likeCount.textColor =[UIColor greenColor];
       }
    [self refreshData];
}

- (void) refreshData {
    //code
}

@end
