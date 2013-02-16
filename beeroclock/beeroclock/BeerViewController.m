//
//  BeerViewController.m
//  beeroclock
//
//  Created by Christopher Coleman on 2/15/13.
//  Copyright (c) 2013 Nom. All rights reserved.
//

#import "BeerViewController.h"

@implementation BeerViewController

@synthesize groupMessage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager startUpdatingLocation];

        messageComposer = [[MFMessageComposeViewController alloc] init];
        messageComposer.messageComposeDelegate = self;

        groupTable = [[UITableView alloc] init];
        [groupTable setDelegate:self];
        selectedGroup = nil;
        groups = [[NSArray alloc] initWithObjects:@"Test1",@"Test2",@"Test3",@"Test4",@"Test5",@"Test6",@"Test7", nil];
    }

    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@", newLocation);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}

- (void)dealloc
{
    [locationManager setDelegate:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultSent:
            [controller dismissViewControllerAnimated:YES completion:NULL];
            break;
        case MessageComposeResultCancelled:
            NSLog(@"Message was cancelled.");
            break;
        case MessageComposeResultFailed:
            NSLog(@"Message failed to send.");
            break;
        default:
            break;
    }
}

- (IBAction)sendMessageToGroup:(id)sender
{
    NSLog(@"Recipients are %@", selectedGroup);
    NSLog(@"body is %@", groupMessage.text);
 
    if ([MFMessageComposeViewController canSendText] == YES) {
        //comment
        messageComposer.recipients = [[NSArray alloc] initWithObjects:selectedGroup, nil];
        messageComposer.body = groupMessage.text;
        [self presentViewController:messageComposer animated:YES completion:NULL];
    }
}

- (IBAction)hideGroupMessageKeyboardOnReturn:(id)sender
{
    [sender resignFirstResponder];
}


- (IBAction)backgroundTouched:(id)sender
{
    [groupMessage resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [groups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"MyCellIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }

    cell.textLabel.text = [groups objectAtIndex:indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedGroup = [groups objectAtIndex:indexPath.row];
}

@end
