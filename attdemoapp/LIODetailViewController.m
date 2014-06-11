//
//  LIODetailViewController.m
//  attdemoapp
//
//  Created by Yaron Karasik on 6/11/14.
//  Copyright (c) 2014 yaronkarasik. All rights reserved.
//

#import "LIODetailViewController.h"

// LPMobile
#import "LIOLookIOManager.h"

@interface LIODetailViewController ()

@property (nonatomic, strong) UIButton *chatButton;

@end

@implementation LIODetailViewController

- (id)initWithAccount:(NSString *)anAccount skill:(NSString *)aSkill
{
    self = [super init];
    if (self)
    {
        self.skill = aSkill;
        self.account = anAccount;
    }
    return self;
}

#pragma mark -
#pragma mark Action Methods

- (void)updateChatButtonState
{
    if ([[LIOLookIOManager sharedLookIOManager] enabled])
        [[LIOLookIOManager sharedLookIOManager] setInvitationShown];
    
    // Button state
    NSString *eventName = [NSString stringWithFormat:@"button-%@-%@", self.account, self.skill];
    if ([[LIOLookIOManager sharedLookIOManager] isChatEnabledForSkill:self.skill forAccount:self.account])
    {
        self.chatButton.alpha = 1.0;
        self.chatButton.enabled = YES;
        
        [[LIOLookIOManager sharedLookIOManager] reportEvent:eventName withData:@"1"];
    }
    else
    {
        self.chatButton.alpha = 0.3;
        self.chatButton.enabled = NO;
        
        [[LIOLookIOManager sharedLookIOManager] reportEvent:eventName withData:@"0"];
    }
}

- (void)chatButtonWasTapped:(id)sender
{
    [[LIOLookIOManager sharedLookIOManager] beginChatWithSkill:self.skill withAccount:self.account];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // Funnel state based on default skill
    [[LIOLookIOManager sharedLookIOManager] setChatAvailable];
    [self updateChatButtonState];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // Funnel State
    [[LIOLookIOManager sharedLookIOManager] setInvitationNotShown];
    [[LIOLookIOManager sharedLookIOManager] setChatUnavailable];
    
    // Button State
    NSString *eventName = [NSString stringWithFormat:@"button-%@-%@", self.account, self.skill];
    [[LIOLookIOManager sharedLookIOManager] reportEvent:eventName withData:@"-1"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.chatButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 100, 240, 60)];
    self.chatButton.layer.cornerRadius = 5.0;
    self.chatButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.chatButton setTitle:@"Contact Representative" forState:UIControlStateNormal];
    self.chatButton.backgroundColor = [UIColor lightGrayColor];
    [self.chatButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.chatButton addTarget:self action:@selector(chatButtonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.chatButton.enabled = NO;
    self.chatButton.alpha = 0.3;
    [self.view addSubview:self.chatButton];
    
    UILabel *detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, self.view.bounds.size.width - 40, 30)];
    detailsLabel.textColor = [UIColor blackColor];
    detailsLabel.textAlignment = UITextAlignmentCenter;
    detailsLabel.text = [NSString stringWithFormat:@"%@ / %@", self.account, self.skill];
    detailsLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    detailsLabel.numberOfLines = 0;
    [detailsLabel sizeToFit];
    
    [self.view addSubview:detailsLabel];
    
    self.navigationItem.title = @"Chat Page";
}

@end
