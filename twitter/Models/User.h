//
//  User.h
//  twitter
//
//  Created by Nikki Tran on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

// TODO: Add properties

// TODO: Create initializer

// MARK: Properties
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSURL *profileURL;
@property int followingCount;
@property int followersCount;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) NSURL *bannerPicURL;

// Add any additional properties here

// Create initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
