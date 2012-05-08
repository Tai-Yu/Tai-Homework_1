//
//  ViewController.m
//  homework_1
//
//  Created by Tai-Yu Huang on 4/29/12.
//  Copyright (c) 2012 Intuary. All rights reserved.
//
//Tai:When U press Animate button, animated Bird(not just a image) starting to fly, once it flies downward, it'll call another method, and then another one, then it goes into a loop.

//Tai:When u tap the bird, the bird'll disappear in 4 secs(there are some bugs, sometimes can't call the method when I tap it.)
//



#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

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
    
    //set up background image.
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1080, 1636)];
    imageView.image = [UIImage imageNamed:@"background.jpg"];
   
    //set up scroll view.
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 100, 580, 800)];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.alwaysBounceHorizontal = YES;
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    scrollView.contentSize = CGSizeMake(2048, 1536);
    
    //add background image and button into scrollview. 
    [scrollView addSubview:imageView];
    [scrollView addSubview:button];
    [self.view addSubview:scrollView];
    [super viewDidLoad];
    	// Do any additional setup after loading the view, typically from a nib.
}



//Animate button pressed
-(void)moveAnimation{
    
    //set up when user tap.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kickBird:)];
    
    
   //set More than one images to bird(makes it fly).<--this function can make an Animation moves, not just an image moves.
    bird = [[UIImageView alloc]initWithFrame:CGRectMake(150, 150, 500, 500)];
    bird.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"bird"],
                            [UIImage imageNamed:@"bird2"],
                            [UIImage imageNamed:@"bird3"],nil];
    bird.animationDuration = 0.2;
    bird.animationRepeatCount = 0;
    [bird startAnimating];
    
    //set up bird's animation.
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDidStopSelector:@selector(moveLeft:finished:context:)];
    bird.center = CGPointMake(500.0, 600.0);
    
    bird.userInteractionEnabled = YES;//
    [bird addGestureRecognizer:tap];//this two line make the bird tappable.
    [UIView setAnimationDelegate:self];
   
    //add bird to scrollview.
    [scrollView addSubview:self.bird];  
    [UIView commitAnimations];
}

//when first animation stops it'll call |moveLeft|, then bird moves to left.
-(void)moveLeft:(NSString *)animationID
finished:(NSNumber *)finished
context:(void *)context{
     if(birdDead) return;
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

//when bird's |moveLeft| ends, it'll call |moveUp|, then bird moves up.
-(void)moveUp:(NSString *)animationID
       finished:(NSNumber *)finished
        context:(void *)context{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(moveDown:finished:context:)];
    
    bird.center = CGPointMake(600.0, 300.0);//move bird to this location.
    bird.transform = CGAffineTransformMakeRotation(0.3);//rotate bird.
    
   
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
}

//when bird's |moveUp| finished, it'll call|moveDown|, then the bird'll move down.
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

//when user tap the bird, it'll call|kickBird|, then bird'll fly away and disappear.
-(void)kickBird:(UITapGestureRecognizer *)sender{
    birdDead = true;
    //[UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];

    [UIView animateWithDuration:4 
                          delay:0.0 
                        options:UIViewAnimationCurveEaseOut 
                     animations:^{
                         bird.transform = CGAffineTransformMakeRotation(0.1);
                     } 
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:3.0
                                               delay:2.0 
                                             options:0 
                                          animations:^{
                                              bird.transform = CGAffineTransformMakeScale(0.3, 0.3);
                                              bird.center = CGPointMake(200.0, 200.0);
                                              bird.alpha = 0.0;
                                          } completion:^(BOOL finished){
                                              [bird removeFromSuperview];
                                              birdDead= nil;
                                          }];
                     }];
    

    
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
