//
//  ViewController.h
//  sqliteTutorial
//
//  Created by Anthony Dagati on 10/28/14.
//  Copyright (c) 2014 Black Rail Capital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "Person.H"


@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

{
    NSMutableArray *arrayOfPerson;
    sqlite3 *personDB;
    NSString *dbPathString;
}
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UITextField *ageField;

- (IBAction)addButton:(id)sender;
- (IBAction)deleteButton:(id)sender;
- (IBAction)displayButton:(id)sender;

@end

