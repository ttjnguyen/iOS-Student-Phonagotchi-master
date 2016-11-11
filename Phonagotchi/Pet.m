//
//  Pet.m
//  Phonagotchi
//
//  Created by Jenny Nguyen on 2016-11-10.
//  Copyright © 2016 Lighthouse Labs. All rights reserved.
//

#import "Pet.h"

@implementation Pet

-(void)petting:(CGPoint)velocity {
    if (velocity.x > 1200) {
        NSLog(@"%@", NSStringFromCGPoint(velocity));
    }

    if (velocity.x > 2000) {
        self.isGrumpy = YES;
    } else if ((velocity.x > 20) && (velocity.x < 2000)) {
        self.isGrumpy = NO;
    }
}

@end
