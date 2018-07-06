//
//  TweetCell.h
//  twitter
//
//  Created by Nikki Tran on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"


@interface TweetCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *screenName;
@property (strong, nonatomic) IBOutlet UILabel *createdAt;
@property (strong, nonatomic) IBOutlet UILabel *tweetText;
@property (strong, nonatomic) IBOutlet UILabel *retweetCount;
@property (strong, nonatomic) IBOutlet UILabel *favoriteCount;
@property (strong, nonatomic) IBOutlet NSDate *timeAgoDate;

@property (strong, nonatomic) Tweet *tweet;

-(void)configureCell: (Tweet *) tweet;

@end
