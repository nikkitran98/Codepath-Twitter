//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "TimelineViewController.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetViewController.h"
#import "Tweet.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *tweets;
@property (weak, nonatomic) IBOutlet UITableView *tweetView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // getting data from view controller
    self.tweetView.dataSource = self;
    self.tweetView.delegate = self;
    
    //self.tweetView.rowHeight = 150;
    
    self.tweets = [[NSMutableArray alloc] init];
    
    [self fetchTweets];
    
    // initialize UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    // bind action to refresh control
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tweetView insertSubview:self.refreshControl atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // gets cell
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    
    // associates tweets with cell
    Tweet *tweet = self.tweets[indexPath.row];
    [cell configureCell:tweet];
    return cell;
}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl

- (void) fetchTweets {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweets = [[NSMutableArray alloc] initWithArray:tweets];
            
            [self.tweetView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
            [self.tweetView reloadData];
        }
        [self.refreshControl endRefreshing];
    }];
}

- (IBAction)didTapLogout:(id)sender {
    [UIApplication sharedApplication].delegate;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Change the selected background view of the cell.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqual:@"ComposeTweet"]){
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = [segue destinationViewController];
        composeController.delegate = self;
    }
    else if([segue.identifier isEqual:@"tweetDetails"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        TweetViewController *tweetViewController = navigationController.viewControllers[0];
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tweetView indexPathForCell:tappedCell];
        Tweet *tweet = self.tweets[indexPath.row];
        tweetViewController.tweet = tweet;
    }
}


@end
