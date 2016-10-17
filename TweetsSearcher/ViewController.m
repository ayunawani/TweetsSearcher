//
//  ViewController.m
//  TweetsSearcher
//
//  Created by Ayush Nawani on 15/10/16.
//  Copyright © 2016 Ayush Nawani. All rights reserved.
//

#import "ViewController.h"
#import "DisplayTweets.h"

@interface ViewController ()
{
    NSString *_text;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchTweet:(id)sender {
    
//    _text = [self validateTweet:self.searchBox.text];
}

-(NSString*)validateTweet:(NSString*)searchString {
    NSRange hashIndex = [searchString rangeOfString:@"#"];
    NSString *text = nil;
    if (hashIndex.location != NSNotFound) {
        NSString *text = [searchString substringWithRange:NSMakeRange(hashIndex.length, (searchString.length-1 ))];
        
        return text;
    }
    return text;
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {

    _text = [self validateTweet:self.searchBox.text];
    
    if(_text.length == 0 ) {
        
        self.validationLabel.text = @"No text";
        self.validationLabel.textAlignment = NSTextAlignmentCenter;
        return  NO;
    }
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DisplayTweets *displayTweets = (DisplayTweets*)segue.destinationViewController;
    displayTweets.searchTag = _text;
}



@end
