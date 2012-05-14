//
//  ViewController.m
//  homework_1
//
//  Created by Tai-Yu Huang on 4/29/12.
//  Copyright (c) 2012 Intuary. All rights reserved.
//
//Tai:Can we also save images to plist?
//Tai:line 82-85 I simplify it.
//Tai:try new stuff, when user taps, get the location.


#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end
@implementation ViewController
@synthesize arrayPosition;
@synthesize tapExplosion;
@synthesize tap;
@synthesize arrayAnimationCurve;
@synthesize arrayDuration;
@synthesize bird;

- (void)viewDidLoad
{
    
    //read the bird.plish
    //this is a test of gennady_branch
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bird" ofType:@"plist"];

    //Array the positions and animationCurve.
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    arrayPosition = [NSMutableArray arrayWithArray:[dic objectForKey:@"position"]];
    arrayAnimationCurve = [NSMutableArray arrayWithArray:[dic objectForKey:@"animationCurve"]];
    arrayDuration = [NSMutableArray arrayWithArray:[dic objectForKey:@"Duration"]];
    
    //return the sum of items to index.
    index = [arrayPosition count];
    
    //press this button and bird shows up.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(40, 40, 150, 40)];
    [button setTitle:@"Animate" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tapAnimate) forControlEvents:UIControlEventTouchUpInside];   
    
    //set up background image.
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1080, 1636)];
    imageView.image = [UIImage imageNamed:@"background.jpg"];
    
    //when user tap on back
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kickBird:)];
    tapExplosion =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(explosion:)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tapExplosion];
   
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
-(void)tapAnimate{
   
    //if birdDead is No, bird'll go into loop. otherwise, it'll rotate and disappear.
    birdAlive = YES;
    
   //set More than one images to bird(makes it fly).<--this function can make an Animation moves, not just an image moves.
    bird = [[UIImageView alloc]initWithFrame:CGRectMake(150, 150, 250, 250)];
    bird.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"bird"],[UIImage imageNamed:@"bird2"],[UIImage imageNamed:@"bird3"],[UIImage imageNamed:@"bird4"],[UIImage imageNamed:@"bird5"],[UIImage imageNamed:@"bird6"],[UIImage imageNamed:@"bird7"],[UIImage imageNamed:@"bird8"],nil];
    
    bird.animationDuration = 0.2;
    bird.animationRepeatCount = 0;
    [bird startAnimating];
       
    bird.userInteractionEnabled = YES;//
    [bird addGestureRecognizer:tap];//this two line make the bird tappable.

    //set up bird's animation->simplify it, I wanna call |moveToNextPosition| immediately.
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(moveToNextPosition:finished:context:)];
    [UIView commitAnimations];
   
    //add bird to scrollview.
    [scrollView addSubview:self.bird];  
    
}

//when tapAnimate finished, it'll get call
-(void)moveToNextPosition:(NSString *)animationID
                 finished:(NSNumber *)finished
                  context:(void *)context{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    
    //if birdAlive is yes, bird'll keep flying.
    if(birdAlive){
        
        //start animating from last item.
        //if index <=0, reset the index, and call moveToNextPosition again.
        if(index<=0){
            
            index=[arrayPosition count];
            
        }
        
        index--;
        NSString *positon = [arrayPosition objectAtIndex:index];
        NSString *duration =[arrayDuration objectAtIndex:index];
        NSNumber *animationCurve = [arrayAnimationCurve objectAtIndex:index];
        
        [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
        [UIView setAnimationDuration:(NSTimeInterval)[duration floatValue]];//convert string to float.
        CGPoint nextPoint = CGPointFromString(positon);
        bird.center = nextPoint;
        
        //show the next position and animationcurve in output.
        NSLog(@"%@",positon);
        NSLog(@"%@",animationCurve);
        NSLog(@"%@",duration);
        
        
        
        [UIView setAnimationDidStopSelector:@selector(moveToNextPosition:finished:context:)];
       
     //if birdAlive is No, it'll rotate and disppear.   
    }else {
        
        [UIView animateWithDuration:0.5 
                              delay:0.0 
                            options:UIViewAnimationCurveEaseOut 
                         animations:^{                             
                             bird.transform = CGAffineTransformMakeRotation(0.3);
                         } 
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:3.0
                                                   delay:0.5 
                                                 options:0 
                                              animations:^{
                                                  bird.transform = CGAffineTransformMakeScale(0.3, 0.3);
                                                  bird.center = CGPointMake(200.0, 200.0);
                                                  bird.alpha = 0.0;
                                              } completion:^(BOOL finished){
                                                  [bird removeFromSuperview];
                                              }];
                         }];


    }
    [UIView commitAnimations];
}

//when user tap the bird, it'll call|kickBird|, then set birdDead to yes.Then the bird won't go into the loop.
-(void)kickBird:(UITapGestureRecognizer *)sender{
    birdAlive = NO;
    NSLog(@"Dead!");
}

//getting location from user and do bomb animation.
-(void)explosion:(UITapGestureRecognizer *)recognizer{
    CGPoint location = [recognizer locationInView:self.view];//get the location when user tap
    
    UIImageView *imageExplosion = [[UIImageView alloc]initWithFrame:CGRectMake(location.x-150, location.y-150, 100, 100)];
    imageExplosion.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"explosion_0"],[UIImage imageNamed:@"explosion_1"],[UIImage imageNamed:@"explosion_2"],[UIImage imageNamed:@"explosion_3"],[UIImage imageNamed:@"explosion_4"],[UIImage imageNamed:@"explosion_5"],[UIImage imageNamed:@"explosion_6"],[UIImage imageNamed:@"explosion_7"],[UIImage imageNamed:@"explosion_8"],[UIImage imageNamed:@"explosion_9"],[UIImage imageNamed:@"explosion_10"],[UIImage imageNamed:@"explosion_11"],[UIImage imageNamed:@"explosion_12"],[UIImage imageNamed:@"explosion_13"],[UIImage imageNamed:@"explosion_14"],nil];
    
    imageExplosion.animationDuration = 0.5;
    imageExplosion.animationRepeatCount = 1;
    [imageExplosion startAnimating];
    [scrollView addSubview:imageExplosion];
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
