//
//  ProfileViewController.m
//  twitter
//
//  Created by Nikki Tran on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // calls api account details
    [[APIManager shared] getAccountDetails:^(User *user, NSError *error) {
        if (user) {
            self.user = user;
            self.name.text = self.user.name;
            self.screenName.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
            
            self.profileImage.image = nil;
            self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2;
            [self.profileImage setImageWithURL:self.user.profileURL];
            
            self.bannerImage.image = nil;
            [self.bannerImage setImageWithURL:self.user.bannerPicURL];
            
            // bio, followers and following count
            self.followingCount.text = [NSString stringWithFormat:@"%d", self.user.followingCount];
            
            self.followersCount.text = [NSString stringWithFormat:@"%d", self.user.followersCount];
            
            self.bio.text = self.user.bio;
            
            NSLog(@"Yo");
        }
        else {
            NSLog(@"Failed");
        }
    }];
    
    // calls banner image api path
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
