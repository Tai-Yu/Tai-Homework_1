//
//  ViewController.m
//  homework_1
//
//  Created by Tai-Yu Huang on 4/29/12.
//  Copyright (c) 2012 Intuary. All rights reserved.
//



#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end
@implementation ViewController
@synthesize arrayPosition;
@synthesize arrayAnimationCurve;
@synthesize bird;

- (void)viewDidLoad
{
    
    //read the bird.plish
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bird" ofType:@"plist"];
    
    //Array the positions and animationCurve.
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    arrayPosition = [NSMutableArray arrayWithArray:[dic objectForKey:@"coordinates"]];
    arrayAnimationCurve = [NSMutableArray arrayWithArray:[dic objectForKey:@"animationCurve"]];
    
    //return the sum of items to index.
    indexPosition = [arrayPosition count];
    indexAnimation = [arrayAnimationCurve count];
    
    //press this button and bird shows up.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(100, 100, 150, 40)];
    [button setTitle:@"Animate" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tapAnimate) forControlEvents:UIControlEventTouchUpInside];   
    
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
-(void)tapAnimate{
    
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
    [UIView setAnimationDidStopSelector:@selector(moveToNextPosition:finished:context:)];
    bird.center = CGPointMake(500.0, 600.0);
    
    bird.userInteractionEnabled = YES;//
    [bird addGestureRecognizer:tap];//this two line make the bird tappable.
    [UIView setAnimationDelegate:self];
   
    //add bird to scrollview.
    [scrollView addSubview:self.bird];  
    [UIView commitAnimations];
}

//when tapAnimate finished, it'll get call
-(void)moveToNextPosition:(NSString *)animationID
                 finished:(NSNumber *)finished
                  context:(void *)context{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationBeginsFromCurrentState:YES];
   
    //start animating from last item.
    //in reality, |indexPosition| should equal to |indexAnimation|, if not, it'd make the if()else() so complicated.
    if(indexPosition>0 && indexAnimation>0){
        
        NSString *positon = [arrayPosition objectAtIndex:--indexPosition];
        NSNumber *animationCurve = [arrayAnimationCurve objectAtIndex:--indexAnimation];
        
        [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
        CGPoint nextPoint = CGPointFromString(positon);
        bird.center = nextPoint;

        //show the next position and animationcurve in output.
         NSLog(@"%@",positon);
        NSLog(@"%@",animationCurve);
         
    } 
    
    //if index becomes-1, reset the index, and call moveToNextPosition again.
    //Tai:Right now I need a last animation inorder to call|setAnimationDidStopselector|, I don't know if there is a way to just call himself again.
    else{
        
        indexPosition=[arrayPosition count];
        indexAnimation=[arrayAnimationCurve count];
                
        }
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(moveToNextPosition:finished:context:)];
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
