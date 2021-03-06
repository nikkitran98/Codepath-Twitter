//
//  ComposeViewController.m
//  twitter
//
//  Created by Nikki Tran on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetView;

@end

@implementation ComposeViewController

- (IBAction)closeAction:(id)sender {
     [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)tweetAction:(id)sender {
    [[APIManager shared] postStatusWithText:(self.tweetView.text) completion:^(Tweet * tweets, NSError * error) {
        if (tweets) {
//            NSLog(@"😎😎😎 Successfully loaded home timeline");
//            self.tweets = [[NSMutableArray alloc] initWithArray:tweets];
//            
//            [self.tweetView reloadData];
            [self dismissViewControllerAnimated:true completion:nil];
            
        }
        else {
//            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
//            [self.tweetView reloadData];
        }
//        [self.refreshControl endRefreshing];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTweet:(Tweet *)tweet {
    
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
