//
//  ViewController.m
//  homework_1
//
//  Created by Tai-Yu Huang on 4/29/12.
//  Copyright (c) 2012 Intuary. All rights reserved.
//
//Tai:When U press Animate button, animated Bird(not just a image) starting to fly, once it flies downward, it'll call another method, and then another one, then it goes into a loop.

//Tai:When u tap the bird, the bird'll disappear in 4 secs(there are some bugs, sometimes can't call the method when I tap it.)



#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end
@implementation ViewController
@synthesize bird;

- (void)viewDidLoad
{
    //read in plist configuration file
    /*
     From FarFaria:
     NSString *path = [[NSBundle mainBundle] pathForResource:@"bird" ofType:@"plist"];
     // Build the array from the plist  
     NSFileManager *fileManager = [NSFileManager defaultManager];
     
     if ([fileManager fileExistsAtPath: path]) {
     NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
     NSMutableArray *array2 = [NSMutableArray arrayWithArray:[dic objectForKey:@"Root"]]; 
     [templates setObject:array2 forKey:land];    
     NSString *signLocation = [dic objectForKey:@"Sign"];
     if (signLocation) {
     [templates setObject:signLocation forKey:[NSString stringWithFormat:@"%@_sign", land]];   
     }
     NSString *topLeft = [dic objectForKey:@"Top_Left"];
     if (topLeft) {
     [templates setObject:topLeft forKey:[NSString stringWithFormat:@"%@_Top_Left", land]];
     }
     NSString *bottomRight = [dic objectForKey:@"Bottom_Right"];
     if (bottomRight) {
     [templates setObject:bottomRight forKey:[NSString stringWithFormat:@"%@_Bottom_Right", land]];
     }

     YOu'll need to use this method to convert the string to a CGPoint: CGPointFromString()
     
     */
     
   
    //press this button and bird shows up.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(100, 100, 150, 40)];
    [button setTitle:@"Animate" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(moveAnimation) forControlEvents:UIControlEventTouchUpInside];   
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1080, 1636)];
    imageView.image = [UIImage imageNamed:@"background.jpg"];
   
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
-(void)moveAnimation{//rename startAnimation or didTapAnimate

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kickBird:)];
    
    
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
    bird.userInteractionEnabled = YES;//
    [bird addGestureRecognizer:tap];//this two line make the bird tappable.
    [UIView setAnimationDelegate:self];
   
   
    [scrollView addSubview:self.bird];  
    [UIView commitAnimations];
}

-(void)moveLeft:(NSString *)animationID//change moveLeft to moveToNextPosition
finished:(NSNumber *)finished
context:(void *)context{
     if(birdDead) return;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];//GB instead of manual animation curve. figure out next animationCurve based on config
    [UIView setAnimationDidStopSelector:@selector(moveUp:finished:context:)];//CALL YOURSELF INSTEAD OF MOVEUP
    
    
    bird.center = CGPointMake(300.0, 500.0);//move bird to this location.
    //GB instead of manual point. figure out next position based on configuration
    
    bird.transform = CGAffineTransformMakeScale(1.2, 1.2);//Scale up bird's size.
   
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

-(void)moveUp:(NSString *)animationID//REMOVE
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

-(void)moveDown:(NSString *)animationID//REMOVE
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
