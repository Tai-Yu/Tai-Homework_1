//
//  ViewController.m
//  homework_1
//
//  Created by Tai-Yu Huang on 4/29/12.
//  Copyright (c) 2012 Intuary. All rights reserved.
//

//Tai:Nothing changed from"Animate"button.

//Tai:when u press "Test" button, it seems have two animation, but all it does is animation reverse.

// Tai:when u press "Move" button, the bird'll fly to the bottom right, after the animation stops, it'll call another method to perform another animation, which is the bird(another one) flies to the bottom left. but I have to create another UIImageview. I don't know if there is way to share the bird image and when the first animation stops , I want to pass all the value(position) to next animation, that way I can acturelly animate the same image.

//Tai:Seems like I don't have CoreAnimation(CA)framework, so I can't use any CA.....function, like CAKeyframeanimation....How can I get that? Gennady do you have a uptodate Core Animation book? the one u have is 2009.

//Tai:I can't find another way to get image, so I still use the old fashion way[UIImage imageNamed:@""];
//Tai:Can u show me some examples to use delegate, I still don't know when and how to use delegate.

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{

    //press this button and the bird will fly around.(homework_2)
    UIButton *moveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [moveButton setFrame:CGRectMake(200, 0, 150, 40)];
    [moveButton setTintColor:[UIColor greenColor]];
    [moveButton setTitle:@"Move" forState:UIControlStateNormal];
    [moveButton addTarget:self action:@selector(moveAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    //press this button and my business card disappears.
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];//<-test
    [testButton setHighlighted:YES];
    [testButton setFrame:CGRectMake(0, 0, 150, 40)];
    [testButton setTitle:@"Test" forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(animationTest) forControlEvents:UIControlEventTouchUpInside];
    
    //press this button and cake shows up.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(80, 50, 150, 40)];
    [button setTitle:@"Animate" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didPressAnimate) forControlEvents:UIControlEventTouchUpInside];
   
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 2048, 1536)];
    imageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"adventure_overlay.jpg"], 
                                 [UIImage imageNamed:@"animal_overlay.jpg"],
                                 [UIImage imageNamed:@"bedtime_overlay.jpg"],
                                 [UIImage imageNamed:@"classic_overlay.jpg"],
                                 [UIImage imageNamed:@"fairytale_overlay.jpg"],nil];
    imageView.animationDuration = 12;//12 seconds for all pics.
    imageView.animationRepeatCount = 0;//repeat forever.
    [imageView startAnimating];
   
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 100, 580, 800)];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.alwaysBounceHorizontal = NO;
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    scrollView.contentSize = CGSizeMake(2048, 1536);
    
    //[scrollView addSubview:moveButton];//<-Homework2(Tai:I can't add any new button to scrollview.)
    [self.view addSubview:moveButton];
    [self.view addSubview:testButton];//<-test
    [scrollView addSubview:imageView];
    [scrollView addSubview:button];
    [self.view addSubview:scrollView];
    [super viewDidLoad];
    	// Do any additional setup after loading the view, typically from a nib.
}

//bird's first animation starts.
-(void)moveAnimation{

   
    UIImageView *bird = [[UIImageView alloc]initWithFrame:CGRectMake(150, 150, 500, 500)];
    bird.image = [UIImage imageNamed:@"bird"];
    
    [scrollView addSubview:bird];
    [self moveImage:bird duration:10.0 curve:UIViewAnimationCurveEaseInOut x:1710.0 y:1086.0];
  
}

//move animation.
-(void)moveImage:(UIImageView *)image duration:(NSTimeInterval)duration curve:(int)curve x:(CGFloat)x y:(CGFloat)y{
    
    [UIView beginAnimations:@"coolAnimation" context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    image.transform = transform;
    [UIView setAnimationDidStopSelector:@selector(keepMoving:finished:context:)];
    [UIView commitAnimations];
    
}


//call this method when bird's first animation stops.
-(void)
keepMoving:(NSString *)animationID
finished:(BOOL)finished
context:(void *)context
{
    if([animationID isEqualToString:@"coolAnimation"])
    {
        
        UIImageView *bird_2 = [[UIImageView alloc]initWithFrame:CGRectMake(1710.0, 1086.0, 500, 500)];
        bird_2.image = [UIImage imageNamed:@"bird"];
      
        
        [self moveImage_2:bird_2 duration:8 curve:UIViewAnimationCurveEaseInOut x:-1610.0 y:-500.0];
        //if i call moveImage, i'll get into infinite loop;
        [scrollView addSubview:bird_2];

           
    }
    else{
        
           NSLog(@"dont know why?");
    }
}


//bird's second animation.
-(void)moveImage_2:(UIImageView *)image2 duration:(NSTimeInterval)duration curve:(int)curve x:(CGFloat)x y:(CGFloat)y{
    
    [UIView beginAnimations:nil context:NULL];
   // [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    image2.transform = transform;
    [UIView commitAnimations];
}

//my business card moves back and forth.
-(void)animationTest{

    
    UIImageView *card = [[UIImageView alloc]initWithFrame:CGRectMake(150, 150, 309.5, 159.5)];
    card.image = [UIImage imageNamed:@"bussinessCard.jpg"];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationRepeatAutoreverses:YES];//let the image back to where it was.
    CGPoint p = card.center;
    //p.x += 300;
    p.y += 300;
    card.center = p;
    [UIView setAnimationDuration:5];
    p = card.center;
    //p.x -= 300;
    p.y -= 300;
    card.center = p;
   // [UIView setAnimationDuration:3];
   // card.alpha = 0;
    [UIView commitAnimations];
    [scrollView addSubview:card];
    
}


//cake animation when animate button pressed.
-(void)didPressAnimate{
    

    
    UIImageView *animation = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cake.jpg"]];
    animation.frame = CGRectMake(10, 10, 338, 450);
    [scrollView addSubview:animation];
    [self moveImage:animation duration:20.0 curve:UIViewAnimationCurveEaseInOut x:1710.0 y:1086.0];
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
