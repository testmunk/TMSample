//
//  AMViewController.m
//  SlideoutStoryboardSample
//
//  Created by Andrea on 15/02/13.
//  Copyright (c) 2013 Andrea Mazzini. All rights reserved.
//

#import "TDSliderContainerViewController.h"
#import "TableViewController.h"
#import "TDAppDelegate.h"
#import "AMSlideOutNavigationController.h"

#import "UIColor+FlatUI.h"
#import "UISlider+FlatUI.h"
#import "UIStepper+FlatUI.h"
#import "UITabBar+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "FUIButton.h"
#import "FUISwitch.h"
#import "UIFont+FlatUI.h"
#import "FUIAlertView.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UIProgressView+FlatUI.h"
#import "FUISegmentedControl.h"
#import "UIPopoverController+FlatUI.h"

@interface TDSliderContainerViewController (){
    UIPopoverController *_popoverController;
}


@property (weak, nonatomic) IBOutlet FUIButton *alertViewButton;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet FUISwitch *flatSwitch;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (weak, nonatomic) IBOutlet FUISegmentedControl *flatSegmentedControl;


@end

@implementation TDSliderContainerViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    }
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /** Load EAIntroViews **/
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page1.titleImage = [UIImage imageNamed:@"original"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"This is page2";
    page2.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page3";
    page3.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    //CGRect boun= self.view.bounds;
    //boun.size.height+= 44;
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    intro.bgImage = [UIImage imageNamed:@"introBg"];
    [intro setDelegate:self];
    
    [intro showInView:self.view animateDuration:0.0];
    
    /** Load the UIKit elements **/
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"Home";
    self.view.backgroundColor = [UIColor cloudsColor];
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor peterRiverColor]
                                  highlightedColor:[UIColor belizeHoleColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationBar class], nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Plain Table"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(showPlainTableView:)];
    [self.navigationItem.rightBarButtonItem removeTitleShadow];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor],  UITextAttributeTextColor, [UIFont boldSystemFontOfSize:13], UITextAttributeFont, nil] forState:UIControlStateNormal];

    
    self.alertViewButton.buttonColor = [UIColor turquoiseColor];
    self.alertViewButton.shadowColor = [UIColor greenSeaColor];
    self.alertViewButton.shadowHeight = 3.0f;
    self.alertViewButton.cornerRadius = 6.0f;
    self.alertViewButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.alertViewButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.alertViewButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    
    [self.stepper configureFlatStepperWithColor:[UIColor wisteriaColor]
                               highlightedColor:[UIColor wisteriaColor]
                                  disabledColor:[UIColor amethystColor]
                                      iconColor:[UIColor cloudsColor]];
    
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];
    
    self.flatSwitch.onColor = [UIColor turquoiseColor];
    self.flatSwitch.offColor = [UIColor cloudsColor];
    self.flatSwitch.onBackgroundColor = [UIColor midnightBlueColor];
    self.flatSwitch.offBackgroundColor = [UIColor silverColor];
    self.flatSwitch.offLabel.font = [UIFont boldFlatFontOfSize:14];
    self.flatSwitch.onLabel.font = [UIFont boldFlatFontOfSize:14];
    
    [self.labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
        label.font = [UIFont flatFontOfSize:16];
        label.textColor = [UIColor midnightBlueColor];
    }];
    
    self.flatSegmentedControl.selectedFont = [UIFont boldFlatFontOfSize:16];
    self.flatSegmentedControl.selectedFontColor = [UIColor cloudsColor];
    self.flatSegmentedControl.deselectedFont = [UIFont flatFontOfSize:16];
    self.flatSegmentedControl.deselectedFontColor = [UIColor cloudsColor];
    self.flatSegmentedControl.selectedColor = [UIColor amethystColor];
    self.flatSegmentedControl.deselectedColor = [UIColor silverColor];
    self.flatSegmentedControl.dividerColor = [UIColor midnightBlueColor];
    self.flatSegmentedControl.cornerRadius = 5.0;


}

- (IBAction)showAlertView:(id)sender {
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Hello" message:@"This is an alert view" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Do Something", nil];
    alertView.delegate = self;
    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont flatFontOfSize:14];
    alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
    alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
    alertView.defaultButtonColor = [UIColor cloudsColor];
    alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor asbestosColor];
    [alertView show];
}

#pragma mark - EAIntroDelegate

-(void)introDidFinish {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view setNeedsLayout];
}

- (void)showPlainTableView:(id)sender {
    TableViewController* tableViewController = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:tableViewController animated:YES];
}



@end
