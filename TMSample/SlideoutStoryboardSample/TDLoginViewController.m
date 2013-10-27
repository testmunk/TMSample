//
//  AViewController.m
//  SlideoutStoryboardSample
//
//  Created by Syed Kashif Zaidi on 10/21/13.
//  Copyright (c) 2013 Andrea Mazzini. All rights reserved.
//

#import "TDLoginViewController.h"
#import "JVFloatLabeledTextField.h"
#import "PXAlertView.h"

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

const static CGFloat kJVFieldHeight = 44.0f;
const static CGFloat kJVFieldHMargin = 10.0f;
const static CGFloat kJVFieldFontSize = 16.0f;
const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@interface TDLoginViewController ()

@end

@implementation TDLoginViewController {
    JVFloatLabeledTextField *emailField, *passwordField;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIView *)generateDivFor:(JVFloatLabeledTextField *)textfield {
    UIView *div = [UIView new];
    div.frame = CGRectMake(kJVFieldHMargin, textfield.frame.origin.y + textfield.frame.size.height,self.view.frame.size.width - 2 * kJVFieldHMargin, 1.0f);
    div.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    return div;
}

- (JVFloatLabeledTextField *)generateTextfieldFor:(CGRect)rect withPlaceholder:(NSString *)placeholder isSecure:(BOOL)secure {
    
    JVFloatLabeledTextField *textfield = [[JVFloatLabeledTextField alloc] initWithFrame:rect];
    textfield.placeholder = NSLocalizedString(placeholder, @"");
    textfield.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    textfield.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    textfield.floatingLabelTextColor = [UIColor grayColor];
    textfield.floatingLabelActiveTextColor = [UIColor darkGrayColor];
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    if(secure)
        textfield.secureTextEntry= YES;
    
    return textfield;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat topOffset = [[UIApplication sharedApplication] statusBarFrame].size.height +
    self.navigationController.navigationBar.frame.size.height - 30;
    
    /*
     *  Login Label
     */
    CGRect rectForLoginLabel =CGRectMake(kJVFieldHMargin,
                                         topOffset + 50.0f,
                                         self.view.frame.size.width - 2 * kJVFieldHMargin,
                                         kJVFieldHeight);
    
    UILabel *signInLabel = [[UILabel alloc] initWithFrame:rectForLoginLabel];
    signInLabel.textAlignment= NSTextAlignmentCenter;
    [signInLabel setText:@"Login to Demo App"];
    signInLabel.textColor = [UIColor grayColor];
    signInLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.view addSubview:signInLabel];
    
    /*
     *  Email
     */
    CGRect rectForEmailField = CGRectMake(kJVFieldHMargin,
                                          topOffset + rectForLoginLabel.size.height+ 50.0f,
                                          self.view.frame.size.width - 2 * kJVFieldHMargin,
                                          kJVFieldHeight);
    
    emailField = [self generateTextfieldFor:rectForEmailField
                                                     withPlaceholder:@"Email"
                                                            isSecure:NO];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        [[UITextField appearance] setTintColor:[UIColor belizeHoleColor]];
    }    
    [self.view addSubview:emailField];
    UIView *emailDiv = [self generateDivFor:emailField];
    [self.view addSubview:emailDiv];
    
    
    /*
     *  Password
     */
    CGRect rectForPasswordField = CGRectMake(kJVFieldHMargin,
                                             emailDiv.frame.origin.y + emailDiv.frame.size.height,
                                             self.view.frame.size.width-2 * kJVFieldHMargin,
                                             kJVFieldHeight);
    
    passwordField = [self generateTextfieldFor:rectForPasswordField
                                                        withPlaceholder:@"Password"
                                                               isSecure:YES];
    passwordField.delegate = self;
    [self.view addSubview:passwordField];
    UIView *passwordDiv = [self generateDivFor:passwordField];
    [self.view addSubview:passwordDiv];
    
    
    /*
     *  SignIn Button
     */
    CGRect rectForSigninButton = CGRectMake(kJVFieldHMargin,
                                            passwordDiv.frame.origin.y+20 + passwordDiv.frame.size.height,
                                            self.view.frame.size.width-2 * kJVFieldHMargin,
                                            kJVFieldHeight);
    
    FUIButton *signIn = [[FUIButton alloc] initWithFrame:rectForSigninButton];
    [signIn addTarget:self action:@selector(signInClicked:) forControlEvents:UIControlEventTouchDown];
    [signIn setTitle:@"SIGN IN" forState:UIControlStateNormal];
    
    signIn.buttonColor = [UIColor cloudsColor];
    signIn.shadowColor = [UIColor asbestosColor];
    signIn.shadowHeight = 3.0f;
    signIn.cornerRadius = 6.0f;
    
    //signIn.titleLabel.textColor = [UIColor grayColor];
    signIn.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [signIn setTitleColor:[UIColor asbestosColor] forState:UIControlStateNormal];
    [signIn setTitleColor:[UIColor asbestosColor] forState:UIControlStateHighlighted];
    
    [self.view addSubview:signIn];
    
}

- (void)signInClicked:(id)sender
{
    
    if(emailField.text.length <= 0 || passwordField.text.length <= 0) {
        [PXAlertView showAlertWithTitle:@"Invalid input!"
                                message:@"Please enter both the username and password to continue."];
        return;
    }
    
    if(passwordField.text.length < 5) {
        [PXAlertView showAlertWithTitle:@"Invalid password!"
                                message:@"Password should be greater than 4 characters."];
        return;
    }
    
    if(![passwordField.text isEqualToString:@"testmunk"]) {
        [PXAlertView showAlertWithTitle:@"Invalid password!"
                                message:@"The username and password you have entered are not correct, please enter the correct details."];
        return;
    }
    
    TDAppDelegate *del = (TDAppDelegate *)[[UIApplication sharedApplication] delegate];
    [del.window setRootViewController:del.AmController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self signInClicked:self];
    return YES;
}


@end
