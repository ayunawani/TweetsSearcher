//
//  TweetsSearcher.h
//  TweetsSearcher
//
//  Created by Ayush Nawani on 15/10/16.
//  Copyright © 2016 Ayush Nawani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayTweets : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSString *searchTag;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loader;
@property (strong, nonatomic) IBOutlet UITableView *tweetsTable;

@end
