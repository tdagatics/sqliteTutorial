//
//  ViewController.m
//  sqliteTutorial
//
//  Created by Anthony Dagati on 10/28/14.
//  Copyright (c) 2014 Black Rail Capital. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayOfPerson = [[NSMutableArray alloc] init];
    [[self myTableView] setDelegate:self];
    [[self myTableView] setDataSource:self];
    [self createOrOpenDB];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createOrOpenDB
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    
    dbPathString = [docPath stringByAppendingPathComponent:@"persons.db"];
    
    char *error;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbPathString]) {
        const char *dbPath = [dbPathString UTF8String];
        //create database here
        if (sqlite3_open(dbPath, &personDB) == SQLITE_OK) {
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PERSON (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, AGE INTEGER)";
            sqlite3_exec(personDB, sql_stmt, NULL, NULL, &error);
            sqlite3_close(personDB);
            
        }
    }
}

- (IBAction)addButton:(id)sender {
    char *error;
    
    if (sqlite3_open([dbPathString UTF8String], &personDB) == SQLITE_OK) {
        NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PERSONS(NAME, AGE) values ('%s' '%d')", [self.nameField.text UTF8String], [self.ageField.text intValue]];
        
        const char *insert_stmt = [insertStmt UTF8String];
        
        if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error) == SQLITE_OK)
        
        
        
        {
        
            NSLog(@"Person added.");
            
            Person *person = [[Person alloc] init];
            
            [person setName:self.nameField.text];
            [person setAge:[self.ageField.text intValue]];
            
            [arrayOfPerson addObject:person];
        }
        sqlite3_close(personDB);
    }
}

- (IBAction)displayButton:(id)sender {
}

- (IBAction)deleteButton:(id)sender {
}

- (IBAction)displayListButton:(id)sender {
}

- (IBAction)deletePersonButton:(id)sender {
}

- (IBAction)displayPersonButton:(id)sender {
}

#pragma mark - TableView Setup

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayOfPerson count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    Person *aPerson = [arrayOfPerson objectAtIndex:indexPath.row];
    
    cell.textLabel.text = aPerson.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", aPerson.age];
    
    return cell;
}

@end
