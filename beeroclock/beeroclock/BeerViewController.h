//
//  BeerViewController.h
//  beeroclock
//
//  Created by Christopher Coleman on 2/15/13.
//  Copyright (c) 2013 Nom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <MessageUI/MessageUI.h>

@interface BeerViewController : UIViewController
    <CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    MFMessageComposeViewController *messageComposer;
    CLLocationManager *locationManager;
    IBOutlet UITextField *groupMessage;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITableView *groupTable;
    NSString *selectedGroup;
    NSArray *groups;
}

- (IBAction)sendMessageToGroup:(id)sender;

@end
