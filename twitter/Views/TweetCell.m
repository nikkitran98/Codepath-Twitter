//
//  TweetCell.m
//  twitter
//
//  Created by Nikki Tran on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell: (Tweet *)tweet {
    _tweet = tweet;
    
    self.name.text = tweet.user.name;
    self.screenName.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.createdAt.text = tweet.createdAtString;
    self.tweetText.text = self.tweet.text;
    
    self.profileImage.image = nil;
    [self.profileImage setImageWithURL:tweet.user.profileURL];
    
    
    self.retweetCount.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.favoriteCount.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
}
@end
