//
//  WebVViewController.m
//  TestmunkDemo
//
//  Created by Syed Kashif Zaidi on 10/22/13.
//  Copyright (c) 2013 Andrea Mazzini. All rights reserved.
//

#import "WebVViewController.h"

@interface WebVViewController ()

@end

@implementation WebVViewController

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
     
     NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"LocalPage" ofType:@"html" inDirectory:nil];
     NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
     //Append javascript
     //NSString *script = @"<script>alert(\"This is an alert!!\");</script>";
     //htmlString = [htmlString stringByAppendingString:script];
     self.webView.delegate = self;
     [self.webView loadHTMLString:htmlString baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
     - (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
         NSURL *URL = [request URL];
         if ([[URL scheme] isEqualToString:@"callmycode"]) {
             NSString *urlString = [[request URL] absoluteString];
             NSArray *urlParts = [urlString componentsSeparatedByString:@":"];
             //check to see if we just got the scheme
             if ([urlParts count] > 1) {
                 NSArray *parameters = [[urlParts objectAtIndex:1] componentsSeparatedByString:@"&"];
                 NSString *methodName = [parameters objectAtIndex:0];
                 NSString *variableName = [parameters objectAtIndex:1];
                 
                 NSString *message = [NSString stringWithFormat:@"methodname=%@ and variablename=%@", methodName, variableName];
                 
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Great" message:message delegate: self cancelButtonTitle: nil otherButtonTitles: @"OK",nil, nil];
                 [alert show];
                 [self.webView stringByEvaluatingJavaScriptFromString:@"alert('Trigger the JS!');"];
             }
         }
         return YES;
     }


@end
