//
//  LIOMainViewController.m
//  attdemoapp
//
//  Created by Yaron Karasik on 6/11/14.
//  Copyright (c) 2014 yaronkarasik. All rights reserved.
//

#import "LIOMainViewController.h"

@interface LIOMainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *accountSkills;

@end

@implementation LIOMainViewController

#pragma mark -
#pragma mark UITableViewDelegate/DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) return self.accountSkills.count;
    if (1 == section) return 1;
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (0 == section) return @"View chat page for";
    if (1 == section) return @"Other actions";
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    switch (indexPath.section) {
        case 0: {
            NSDictionary *accountSkill = (NSDictionary *)[self.accountSkills objectAtIndex:indexPath.row];
            cell.textLabel.text = [accountSkill objectForKey:@"skill"];
            cell.detailTextLabel.text = [accountSkill objectForKey:@"account"];
        }
            break;
            
        case 1:
            if (0 == indexPath.row) cell.textLabel.text = @"Report OrderValue Event";
            
        default:
            break;
    }
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.accountSkills = [NSMutableArray array];
    [self.accountSkills addObject:@{@"account" : @"10188673", @"skill" : @"dsl-care9-mobile-native-english"}];
    [self.accountSkills addObject:@{@"account" : @"1771134", @"skill" : @"wireless-mobile-english"}];
    [self.accountSkills addObject:@{@"account" : @"10188673", @"skill" : @"dslcare13-mobile-ios-english"}];
    [self.accountSkills addObject:@{@"account" : @"1771134", @"skill" : @"service_olam-mobile-ios-english"}];
    [self.accountSkills addObject:@{@"account" : @"59255004", @"skill" : @"mobile"}];
    [self.accountSkills addObject:@{@"account" : @"10188673", @"skill" : @"dslcare9-mobile-web-english"}];
    [self.accountSkills addObject:@{@"account" : @"1771134", @"skill" : @"service-olam-mobile-english"}];
    [self.accountSkills addObject:@{@"account" : @"1771134", @"skill" : @"wireless-mobile-web-english"}];
    [self.accountSkills addObject:@{@"account" : @"1771134", @"skill" : @"wireless-mobile-ios-english"}];
    [self.accountSkills addObject:@{@"account" : @"10188673", @"skill" : @"dsl-care13-mobile-native-english"}];
    [self.accountSkills addObject:@{@"account" : @"10188673", @"skill" : @"dslcare9-mobile-ios-english"}];
        
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

@end
