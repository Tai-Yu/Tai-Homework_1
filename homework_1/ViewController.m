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


- (void)viewDidLoad
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(80, 50, 150, 40)];
    [button setTitle:@"Animate" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didPressAnimate:) forControlEvents:UIControlEventTouchUpInside];
   UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 2048, 1536)];
   // [imageView setImage:[UIImage imageNamed:@"fairytale_overlay.jpg"]];
    imageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"adventure_overlay.jpg"], [UIImage imageNamed:@"animal_overlay.jpg"],[UIImage imageNamed:@"bedtime_overlay.jpg"],[UIImage imageNamed:@"classic_overlay.jpg"],[UIImage imageNamed:@"fairytale_overlay.jpg"],nil];
    imageView.animationDuration = 12;//12 seconds for all pics.
    imageView.animationRepeatCount = 0;//repeat forever.
    [imageView startAnimating];
    [self.view addSubview:imageView];//play with some animation feature.
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 100, 580, 800)];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.alwaysBounceHorizontal = NO;//I can't tell there is any difference between "YES" and "NO".
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    scrollView.contentSize = CGSizeMake(2048, 1536);
    [scrollView addSubview:imageView];
    [scrollView addSubview:button];
    [self.view addSubview:scrollView];
    [super viewDidLoad];
    	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)didPressAnimate:(id)sender{//what's the difference between (ibaction)(id)sender and (void)? 
//GB: IBaction is for when you want to tell Interface Builder about this method
    UIImageView *animation = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cake.jpg"]];//can't use pdf file. GB:pdf is not considered an image
    animation.frame = CGRectMake(10, 10, 338, 450);
    [self.view addSubview:animation];//GB: Why do you add it to both? 
    [scrollView addSubview:animation];
    [self moveImage:animation duration:20.0 curve:UIViewAnimationCurveEaseInOut x:1710.0 y:1086.0];//there are easein or out or line feature.
     //NSLog(@"yeah~~~~");
}
-(void)moveImage:(UIImageView *)image duration:(NSTimeInterval)duration curve:(int)curve x:(CGFloat)x y:(CGFloat)y{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    //CGAffineTransform transform = CGAffineTransformMakeRotation(1.57*2);//rotate
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    image.transform = transform;
    
    [UIView commitAnimations];
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
