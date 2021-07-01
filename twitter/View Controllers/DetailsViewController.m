//
//  DetailsViewController.m
//  twitter
//
//  Created by Jacqueline DiMonte on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *detailImage;
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

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *user = self.tweet.user;
    self.detailName.text = user.name;
    self.detailUsername.text = user.screenName;
    self.detailText.text = self.tweet.text;
    self.detailDate.text = self.tweet.createdAtString;
    
    self.detailImage.layer.cornerRadius =  self.detailImage.frame.size.width / 2;
    self.detailImage.clipsToBounds = true;
    
    self.dotOne.layer.cornerRadius =  self.dotOne.frame.size.width / 2;
    self.dotOne.clipsToBounds = true;
    self.dotTwo.layer.cornerRadius =  self.dotTwo.frame.size.width / 2;
    self.dotTwo.clipsToBounds = true;
    
//    NSString *URLString = user.profilePicture;
//    NSURL *url = [NSURL URLWithString:URLString];
//    NSData *urlData = [NSData dataWithContentsOfURL:url];
//    [self.detailImage setImageWithURL:url];
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
