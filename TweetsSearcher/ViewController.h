//
//  ViewController.h
//  TweetsSearcher
//
//  Created by Ayush Nawani on 15/10/16.
//  Copyright © 2016 Ayush Nawani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *searchBox;
@property (strong, nonatomic) IBOutlet UILabel *validationLabel;

- (IBAction)searchTweet:(id)sender;
@end

