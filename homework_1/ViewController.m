//
//  ViewController.m
//  homework_1
//
//  Created by Tai-Yu Huang on 4/29/12.
//  Copyright (c) 2012 Intuary. All rights reserved.
//
//Tai:When U press Animate button, animated Bird(not just a image) starting to fly, once it flies downward, it'll call another method, and then another one, then it goes into a loop.

//Tai:I want user to tap the bird, and then the bird flies away, I found there are two ways:
//One is use the function -(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event.
//Two is to create a invincible button.
//But it seems that both way are block by the goddamn scrollview(like scrollview is in front of everything).




#import "ViewController.h"

@interface ViewController ()

@end
@implementation ViewController
@synthesize bird;

- (void)viewDidLoad
{
    //press this button and bird shows up.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(100, 100, 150, 40)];
    [button setTitle:@"Animate" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(moveAnimation) forControlEvents:UIControlEventTouchUpInside];   
    
   
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1080, 1636)];
    imageView.image = [UIImage imageNamed:@"background.jpg"];
    imageView.userInteractionEnabled = YES;
   
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 100, 580, 800)];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.alwaysBounceHorizontal = YES;
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    scrollView.contentSize = CGSizeMake(2048, 1536);
    
 
    [scrollView addSubview:imageView];
    [scrollView addSubview:button];
    [self.view addSubview:scrollView];
    [super viewDidLoad];
    	// Do any additional setup after loading the view, typically from a nib.
}



//Animate button pressed
-(void)moveAnimation{

   //set More than one images to bird(makes it fly).<--this function can make an Animation moves, not just an image moves.
    bird = [[UIImageView alloc]initWithFrame:CGRectMake(150, 150, 500, 500)];
    bird.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"bird"],
                            [UIImage imageNamed:@"bird2"],
                            [UIImage imageNamed:@"bird3"],nil];
    bird.animationDuration = 0.2;
    bird.animationRepeatCount = 0;
    [bird startAnimating];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDidStopSelector:@selector(moveLeft:finished:context:)];
    bird.center = CGPointMake(500.0, 600.0);
    [UIView setAnimationDelegate:self];
   
   
    [scrollView addSubview:self.bird];  
    [UIView commitAnimations];
    
    //[self moveImage:self.bird duration:10.0 curve:UIViewAnimationCurveEaseInOut x:1560.0 y:930.0];
  
}

-(void)moveLeft:(NSString *)animationID
finished:(NSNumber *)finished
context:(void *)context{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDidStopSelector:@selector(moveUp:finished:context:)];
    
    bird.center = CGPointMake(300.0, 500.0);//move bird to this location.
    bird.transform = CGAffineTransformMakeScale(1.2, 1.2);//Scale up bird's size.
   
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];

    
}

-(void)moveUp:(NSString *)animationID
       finished:(NSNumber *)finished
        context:(void *)context{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
  //  [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(moveDown:finished:context:)];
    
    bird.center = CGPointMake(600.0, 300.0);//move bird to this location.
    bird.transform = CGAffineTransformMakeRotation(0.3);//rotate bird.
    
   
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
}

-(void)moveDown:(NSString *)animationID
       finished:(NSNumber *)finished
        context:(void *)context{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(moveLeft:finished:context:)];//go into a loop.
    
    bird.center = CGPointMake(600.0, 750.0);//move bird to this location.
    bird.transform = CGAffineTransformMakeRotation(-0.2);
    bird.transform = CGAffineTransformMakeScale(0.9, 0.9);
    
    [UIView setAnimationDelegate:self];
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
