//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"
#import "Pet.h"

@interface LPGViewController () <UIGestureRecognizerDelegate>

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIImageView *appleImageView;
@property (nonatomic) UIImageView *bucketImageView;
@property (null_unspecified) UIImageView *aApple;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *petTheCat;
@property (strong, nonatomic) UIPinchGestureRecognizer *pinchedApple;
@property (nonatomic) Pet *petCat;
@property (nonatomic) CGRect frame;

-(void)setUpPinchRecognizer;
-(void)moveApple:(UIPinchGestureRecognizer*)pinchGestureRecognizer;

@end

@implementation LPGViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchWithGestureRecognizer:)];
    [self.appleImageView addGestureRecognizer:pinchGestureRecognizer];
    
    
        
	
    
    //frame
    
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.petImageView.image = [UIImage imageNamed:@"default"];
    
    [self.view addSubview:self.petImageView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    // Initialize the gesture
    self.petTheCat = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                             action:@selector(handlePan:)];
        self.petCat = [[Pet alloc]init];
    
    //bucket
    
    self.bucketImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.bucketImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bucketImageView.image = [UIImage imageNamed:@"bucket"];
    self.bucketImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.bucketImageView];
    
    NSLayoutConstraint *bucketImageViewHeight = [NSLayoutConstraint constraintWithItem:self.bucketImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.0];
    
    [self.bucketImageView addConstraint:bucketImageViewHeight];
    
    NSLayoutConstraint *bucketImageViewWidth = [NSLayoutConstraint constraintWithItem:self.bucketImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70.0];
    
    [self.bucketImageView addConstraint:bucketImageViewWidth];
    
    NSLayoutConstraint *bucketImageViewLeft = [NSLayoutConstraint constraintWithItem:self.bucketImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
    
    [self.view addConstraint:bucketImageViewLeft];
    
    NSLayoutConstraint *bucketImageViewBottom = [NSLayoutConstraint constraintWithItem:self.bucketImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:  -10];
    
    [self.view addConstraint:bucketImageViewBottom];
    self.bucketImageView.contentMode = UIViewContentModeScaleAspectFit;

    //apple
    
    self.appleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.appleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.appleImageView.image = [UIImage imageNamed:@"apple"];
    self.appleImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.appleImageView];
    
    NSLayoutConstraint *appleImageViewHeight = [NSLayoutConstraint constraintWithItem:self.appleImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.0];
    
    [self.appleImageView addConstraint:appleImageViewHeight];
    
    NSLayoutConstraint *appleImageViewWidth = [NSLayoutConstraint constraintWithItem:self.appleImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.0];
    
    [self.appleImageView addConstraint:appleImageViewWidth];
    
    NSLayoutConstraint *appleImageViewLeft = [NSLayoutConstraint constraintWithItem:self.appleImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
    
    [self.view addConstraint:appleImageViewLeft];
    
    NSLayoutConstraint *appleImageViewBottom = [NSLayoutConstraint constraintWithItem:self.appleImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:  -20];
    
    [self.view addConstraint:appleImageViewBottom];

    self.appleImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.petCat = [[Pet alloc]init];
    [self petTheCat];
    [self setUpPinchRecognizer];
    
}



-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer{
    
    CGPoint point = [recognizer velocityInView:self.petImageView];
    
    [self.petCat petting:point];
    
    if (self.petCat.isGrumpy) {
        self.petImageView.image = [UIImage imageNamed:@"grumpy"];
    } else if (!self.petCat.isGrumpy) {
        self.petImageView.image = [UIImage imageNamed:@"default"];

    }
}

- (void)setUpPinchRecognizer {
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(moveApple:)];
    [self.appleImageView addGestureRecognizer:pinchGestureRecognizer];
    
}
@end

