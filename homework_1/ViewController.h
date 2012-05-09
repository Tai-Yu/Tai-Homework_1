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
    bool birdDead;
    int indexPosition;
    int indexAnimation;
}
@property(nonatomic, strong) UIImageView *bird;
@property(nonatomic, strong) NSArray *arrayPosition;
@property(nonatomic, strong) NSArray *arrayAnimationCurve;

@end
