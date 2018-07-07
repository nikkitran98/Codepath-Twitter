//
//  TweetViewController.m
//  twitter
//
//  Created by Nikki Tran on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "Tweet.h"

@interface TweetViewController ()

@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.name.text = self.tweet.user.name;
    self.screenName.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.createdAt.text = self.tweet.createdAtString;
    self.tweetText.text = self.tweet.text;
    
    self.profileImage.image = nil;
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2;
    [self.profileImage setImageWithURL:self.tweet.user.profileURL];
    
    
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favoriteCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
}

- (IBAction)didTapRetweet:(id)sender {
    // updates the local tweet model
    if (self.tweet.favorited) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        // send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        // send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    //update cell UI
    [self refreshData];
}

- (IBAction)didTapFavorite:(id)sender {
    // updates the local tweet model
    if (self.tweet.retweeted) {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        // send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unrewteeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        // send a POST request to the POST favorites/create endpoint
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeted tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    //update cell UI
    [self refreshData];
}


- (void)refreshData {
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favoriteCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeAction:(id)sender {
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
