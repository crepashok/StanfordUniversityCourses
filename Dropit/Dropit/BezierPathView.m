//
//  BezierPathView.m
//  Dropit
//
//  Created by Pavlo Cretsu on 2/16/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

#import "BezierPathView.h"


@implementation BezierPathView


- (void)setPath:(UIBezierPath *)path {
    
    _path = path;
    
    [self setNeedsDisplay];
}



- (void)drawRect:(CGRect)rect {
    
    [self.path stroke];
    
}


@end
