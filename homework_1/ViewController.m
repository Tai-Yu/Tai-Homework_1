//
//  ViewController.m
//  homework_1
//
//  Created by Tai-Yu Huang on 4/29/12.
//  Copyright (c) 2012 Intuary. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize scrollView;


- (void)viewDidLoad
{
    
    scrollView.contentSize = CGSizeMake(2048, 1536);
    UIButton *readNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [readNowButton addTarget:self action:@selector(didChooseToReadFeatured:) forControlEvents:UIControlEventTouchUpInside];
    [readNowButton setTag:10];
    [readNowButton setFrame:CGRectMake(598, 174, 167, 39)];
    [readNowButton setImage:[UIImage imageNamed:@"button_read-it-now"] forState:UIControlStateNormal];
    [readNowButton setImage:[UIImage imageNamed:@"button_read-it-now_on"] forState:UIControlStateHighlighted];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
