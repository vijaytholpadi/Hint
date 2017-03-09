//
//  HTMessagesViewController.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTMessagesViewController.h"

//Categories
#import "UIColor+HTColor.h"

//Datasource and Delegates
#import "HTMessagesTableViewDataSource.h"
#import "HTMessagesTableViewDelegate.h"

//Managers
#import "HTServiceManager.h"

//Views
#import "HTNotesTableViewCell.h"

static NSString *notesTableViewCell = @"HTNotesTableViewCell";

@interface HTMessagesViewController ()

@property (nonatomic, strong) HTMessagesTableViewDataSource *tableViewDataSource;
@property (nonatomic, strong) HTMessagesTableViewDelegate *tableViewDelegate;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addNoteButton;

@end

@implementation HTMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self themeScreen];
    [self setupTableViewDataSourceDelegate];
    [self configureTableView];
    [self fetchDataForBeacon:self.beacon];
}

- (void)themeScreen {
    self.view.backgroundColor = [UIColor ht_BlueColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.addNoteButton.backgroundColor = [UIColor ht_YellowColor];
    [self.addNoteButton setTitleColor:[UIColor ht_BlueColor] forState:UIControlStateNormal];
}

- (void)setupTableViewDataSourceDelegate {
    //DataSource
    self.tableViewDataSource = [HTMessagesTableViewDataSource new];
    self.tableView.dataSource = self.tableViewDataSource;

    //Delegate
    self.tableViewDelegate = [HTMessagesTableViewDelegate new];
    self.tableView.delegate = self.tableViewDelegate;
}

- (void)configureTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"HTNotesTableViewCell" bundle:nil] forCellReuseIdentifier:notesTableViewCell];
    self.tableView.estimatedRowHeight = 100.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)fetchDataForBeacon:(CLBeacon*)beacon {
    [HTServiceManager getMessagesForBeacon:beacon withCompletion:^(NSArray *notes) {
        self.tableViewDataSource.notes = [HTNote getNotesArrayForRawArray:notes];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addNoteButtonPressed:(id)sender {
    [self.delegate notesViewControllerDidTapAddNoteForBeacon:self.beacon];
}

@end
