//
//  HTNotesViewController.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTNotesViewController.h"

//Categories
#import "UIColor+HTColor.h"

//Datasource and Delegates
#import "HTNotesTableViewDataSource.h"
#import "HTNotesTableViewDelegate.h"

//Managers
#import "HTServiceManager.h"

//Views
#import "HTNotesTableViewCell.h"

static NSString *notesTableViewCell = @"HTNotesTableViewCell";

@interface HTNotesViewController ()

@property (nonatomic, strong) HTNotesTableViewDataSource *tableViewDataSource;
@property (nonatomic, strong) HTNotesTableViewDelegate *tableViewDelegate;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addNoteButton;

@end

@implementation HTNotesViewController

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
    self.tableViewDataSource = [HTNotesTableViewDataSource new];
    self.tableView.dataSource = self.tableViewDataSource;

    //Delegate
    self.tableViewDelegate = [HTNotesTableViewDelegate new];
    self.tableView.delegate = self.tableViewDelegate;
}

- (void)configureTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"HTNotesTableViewCell" bundle:nil] forCellReuseIdentifier:notesTableViewCell];
    self.tableView.estimatedRowHeight = 100.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)fetchDataForBeacon:(CLBeacon*)beacon {
    [HTServiceManager getNotesForBeacon:beacon withCompletion:^(NSArray *notes) {
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
