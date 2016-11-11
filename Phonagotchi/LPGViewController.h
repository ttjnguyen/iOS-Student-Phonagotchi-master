//
//  LPGViewController.h
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPGViewController : UIViewController

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;

@property (nonatomic,readonly) BOOL isGrumpy;

-(BOOL)isGrumpy;

-(void)handlePinchWithGestureRecognizer:(UIPinchGestureRecognizer *)pinchGestureRecognizer;

@end
