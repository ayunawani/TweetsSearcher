//
//  TweetsSearcher.m
//  TweetsSearcher
//
//  Created by Ayush Nawani on 15/10/16.
//  Copyright © 2016 Ayush Nawani. All rights reserved.
//

#import "DisplayTweets.h"

@interface DisplayTweets ()
{
    NSMutableData *_responseData;
    NSMutableArray *_responseArray;
    NSMutableArray *_images;
}
@end

@implementation DisplayTweets

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _responseArray = [NSMutableArray array];
    _images = [NSMutableArray array];
    
    self.tweetsTable.hidden = YES;
    
    [self.loader startAnimating];
    
    self.loader.hidesWhenStopped = YES;
    
    [self fetchTweetsFromServer:self.searchTag];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)fetchTweetsFromServer:(NSString*)searchTag {
    
    
    NSString *apiKey = @"Bearer AAAAAAAAAAAAAAAAAAAAAArHxQAAAAAAcKmz5nnzfhU9aS5H259c4GMYzxY%3DiUKSVsZd6GZEZgSdA9e2MKh0EBKuYNLyXFT4LCCYuhFeI3PbwW";
    
    NSString *api = [NSString stringWithFormat:@"%@%@%@",@"https://api.twitter.com/1.1/search/tweets.json?q=%23",searchTag,@"&count=20"];
    //NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:api]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:api]];
    [request setValue:apiKey forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/jsonp" forHTTPHeaderField:@"Content-Type" ];
    
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

}
#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [_responseArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"cell"];
        
        [[cell textLabel] setNumberOfLines:5]; // unlimited number of lines
        [[cell textLabel] setLineBreakMode:NSLineBreakByWordWrapping];
        [[cell textLabel] setFont:[UIFont systemFontOfSize: 14.0]];
    }
    else {
        [[cell textLabel] setNumberOfLines:5]; // unlimited number of lines
        [[cell textLabel] setLineBreakMode:NSLineBreakByWordWrapping];
        [[cell textLabel] setFont:[UIFont systemFontOfSize: 14.0]];
    }
    if (!(![_images[indexPath.item]  isEqual: @"no-image"])) {
        cell.imageView.image = _images[indexPath.item];
    }
    cell.textLabel.text = _responseArray[indexPath.item];
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
// A response has been received, this is where we initialize the instance var you created
// so that we can append data to it in the didReceiveData method
// Furthermore, this method is called each time there is a redirect so reinitializing it
// also serves to clear it
_responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSDictionary *array = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:nil];
    NSDictionary *statusesDict = array;
    NSArray *statuses = [statusesDict objectForKey:@"statuses"];
    for (NSInteger i = 0; i < statuses.count; i++) {
        
        NSDictionary *dict = statuses[i];
        NSDictionary *entities = [dict objectForKey:@"entities"];
        if([entities objectForKey:@"media"]) {
            NSArray *media = [entities objectForKey:@"media"];
            NSString *url = [media[0] objectForKey:@"media_url_https"];
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage *image = [UIImage imageWithData:data];
            
            [_images addObject:image];
        }
        else {
            [_images addObject:@"no-image"];
        }
        [_responseArray addObject:[dict objectForKey:@"text"]];
    }
    self.tweetsTable.hidden = NO;
    [self.tweetsTable reloadData];

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}


@end
