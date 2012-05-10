//
//  ViewController.h
//  homework_1
//
//  Created by Tai-Yu Huang on 4/29/12.
//  Copyright (c) 2012 Intuary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    UIScrollView *scrollView;
    bool birdAlive;
    int index;
}
@property(nonatomic, strong) UIImageView *bird;
@property(nonatomic, strong) UITapGestureRecognizer *tap;
@property(nonatomic, strong) UITapGestureRecognizer *tapExplosion;
@property(nonatomic, strong) UIImageView *imageExplosion;
@property(nonatomic, strong) NSArray *arrayPosition;
@property(nonatomic, strong) NSArray *arrayAnimationCurve;
@property(nonatomic, strong) NSArray *arrayDuration;

@end
