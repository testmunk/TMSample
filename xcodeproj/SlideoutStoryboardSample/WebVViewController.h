//
//  WebVViewController.h
//  TestmunkDemo
//
//  Created by Syed Kashif Zaidi on 10/22/13.
//  Copyright (c) 2013 Andrea Mazzini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebVViewController : UIViewController <UIWebViewDelegate>
@property (weak,nonatomic) IBOutlet UIWebView *webView;

@end
