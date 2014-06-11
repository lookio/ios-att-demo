//
//  LIODetailViewController.h
//  attdemoapp
//
//  Created by Yaron Karasik on 6/11/14.
//  Copyright (c) 2014 yaronkarasik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LIODetailViewController : UIViewController

@property (nonatomic, copy) NSString *skill;
@property (nonatomic, copy) NSString *account;

- (id)initWithAccount:(NSString *)account skill:(NSString *)skill;
- (void)updateChatButtonState;

@end
