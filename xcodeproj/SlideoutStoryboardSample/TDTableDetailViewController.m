//
//  TDTableDetailViewController.m
//  TestmunkDemo
//
//  Created by Mashhood Rastgar on 10/24/13.
//  Copyright (c) 2013 Andrea Mazzini. All rights reserved.
//

#import "TDTableDetailViewController.h"
#import "UIColor+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"

@interface TDTableDetailViewController ()

@end

@implementation TDTableDetailViewController

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectedRowLabel.text = self.selectedRow;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(back)];
    
    [self.navigationItem.leftBarButtonItem configureFlatButtonWithColor:[UIColor peterRiverColor]
                                                       highlightedColor:[UIColor pomegranateColor]
                                                           cornerRadius:3];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor],  UITextAttributeTextColor, [UIFont boldSystemFontOfSize:13], UITextAttributeFont, nil] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
