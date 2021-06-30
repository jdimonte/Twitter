//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "UIImageView+AFNetworking.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@property (strong, nonatomic) NSMutableArray* arrayOfTweets;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.refreshControl = [[UIRefreshControl alloc ] init];
    [self.refreshControl addTarget:self action:@selector(loadTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView addSubview:self.refreshControl];
    
    [self loadTweets];
}

- (void) loadTweets {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        //NSLog(@"%@", tweets);
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
//            for (NSDictionary *dictionary in tweets) {
//                NSString *text = dictionary[@"text"];
//                NSLog(@"%@", text);
//            }
            self.arrayOfTweets = tweets;
            [self.tableView reloadData];
            //NSLog(@"%lu", (unsigned long)self.arrayOfTweets.count);
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (IBAction)buttonTapped:(UIBarButtonItem *)sender {
    //[UIApplication sharedApplication].delegate;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}
//
//- (void)beginRefresh:(UIRefreshControl *)refreshControl {
//
//        // Create NSURL and NSURLRequest
//
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
//                                                              delegate:nil
//                                                         delegateQueue:[NSOperationQueue mainQueue]];
//        session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//    
//        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
//                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//    
//           // ... Use the new data to update the data source ...
//
//           // Reload the tableView now that there is new data
//            [self.tableView reloadData];
//
//           // Tell the refreshControl to stop spinning
//            [refreshControl endRefreshing];
//
//        }];
//    
//        [task resume];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    
    cell.tweet = tweet;
    
    cell.tweetName.text = tweet.idStr;
    cell.tweetText.text = tweet.text;
    cell.likeCount.text = [NSString stringWithFormat:@"%i", tweet.favoriteCount];
    cell.retweetCount.text = [NSString stringWithFormat:@"%i", tweet.retweetCount];
    cell.tweetDate.text = tweet.createdAtString;
    
    cell.tweetProfile.layer.cornerRadius =  cell.tweetProfile.frame.size.width / 2;
    cell.tweetProfile.clipsToBounds = true;
    
    //update UI
    UIButton *btnRetweet = (UIButton *)cell.retweetIcon;
    UIButton *btnLike = (UIButton *)cell.likeIcon;
    if(cell.tweet.retweeted == YES){
        cell.retweetCount.textColor = [UIColor greenColor];
        [btnRetweet setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
    }
    else{
        cell.retweetCount.textColor = [UIColor grayColor];
        [btnRetweet setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    }
    if(cell.tweet.favorited == YES){
        cell.likeCount.textColor = [UIColor redColor];
        [btnLike setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
    }
    else{
        cell.likeCount.textColor = [UIColor grayColor];
        [btnLike setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
    }
    
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    [cell.tweetProfile setImageWithURL:url];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) didTweet:(Tweet *)tweet {
    [self.arrayOfTweets addObject:tweet];
    [self.tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}

@end
