//
//  TDTableDetailViewController.h
//  TestmunkDemo
//
//  Created by Mashhood Rastgar on 10/24/13.
//  Copyright (c) 2013 Andrea Mazzini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDTableDetailViewController : UIViewController

@property (strong) NSString *selectedRow;
@property (weak) IBOutlet UILabel *selectedRowLabel;

@end
