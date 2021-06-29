//
//  TweetCell.h
//  twitter
//
//  Created by Jacqueline DiMonte on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *tweetName;
@property (strong, nonatomic) IBOutlet UILabel *tweetUsername;
@property (strong, nonatomic) IBOutlet UILabel *tweetDate;
@property (strong, nonatomic) IBOutlet UILabel *tweetText;
@property (strong, nonatomic) IBOutlet UIImageView *tweetProfile;
@property (strong, nonatomic) IBOutlet UILabel *replyCount;
@property (strong, nonatomic) IBOutlet UILabel *retweetCount;
@property (strong, nonatomic) IBOutlet UILabel *likeCount;
@property (strong, nonatomic) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
