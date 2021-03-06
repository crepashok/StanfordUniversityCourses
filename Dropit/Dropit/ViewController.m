//
//  ViewController.m
//  Dropit
//
//  Created by Pavlo Cretsu on 2/15/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

#import "ViewController.h"
#import "DropitBehavior.h"
#import "BezierPathView.h"


@interface ViewController () <UIDynamicAnimatorDelegate>

@property (weak, nonatomic) IBOutlet BezierPathView *gameView;

@property (strong, nonatomic) UIDynamicAnimator *animator;

@property (strong, nonatomic) DropitBehavior *dropitBehavior;

@property (strong, nonatomic) UIAttachmentBehavior *attachement;

@property (strong, nonatomic) UIView *droppingView;

@end



@implementation ViewController



static const CGSize DROP_SIZE = { 72, 72 };



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}



- (UIDynamicAnimator *)animator {
    
    if (!_animator) {
        
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
        
        _animator.delegate = self;
        
    }
    
    return _animator;
}



- (DropitBehavior *)dropitBehavior {
    
    if (!_dropitBehavior) {
        
        _dropitBehavior = [[DropitBehavior alloc] init];
        
        [self.animator addBehavior:_dropitBehavior];
        
    }
    
    return _dropitBehavior;
}



- (IBAction)tap:(UITapGestureRecognizer *)sender {

    [self drop];
    
}



- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    
    CGPoint gestorePoint = [sender locationInView:self.gameView];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
    
        [self attachDroppingViewToPoint:gestorePoint];
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
        self.attachement.anchorPoint = gestorePoint;
    
    } else if (sender.state == UIGestureRecognizerStateEnded) {
    
        [self.animator removeBehavior:self.attachement];
        
        [self.gameView setPath:nil];
        
    }
}



- (void)attachDroppingViewToPoint:(CGPoint)anchorPoint {

    if (self.droppingView) {
    
        self.attachement = [[UIAttachmentBehavior alloc] initWithItem:self.droppingView attachedToAnchor:anchorPoint];
        
        UIView *droppingView = self.droppingView;
        
        __weak ViewController *weakSelf = self;
        
        self.attachement.action = ^{
        
            UIBezierPath *path = [[UIBezierPath alloc] init];
            
            [path moveToPoint:weakSelf.attachement.anchorPoint];
            
            [path addLineToPoint:droppingView.center];
            
            [weakSelf.gameView setPath:path];
            
        };
        
        self.droppingView = nil;
        
        [self.animator addBehavior:self.attachement];
    }
}



- (void)drop {
    
    CGRect frame;
    
    frame.origin = CGPointZero;
    
    frame.size = DROP_SIZE;
    
    int x = (arc4random() % (int) self.gameView.frame.size.width) / DROP_SIZE.width;
    
    frame.origin.x = x * DROP_SIZE.width;
    
    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    
    dropView.backgroundColor = [self randomColor];
    
    [self.gameView addSubview:dropView];
    
    [self setDroppingView:dropView];
    
    [self.dropitBehavior addItem:dropView];
}



- (UIColor *)randomColor {
    
    switch (arc4random() % 5) {
        case 0: return [UIColor greenColor];
        case 1: return [UIColor blueColor];
        case 2: return [UIColor orangeColor];
        case 3: return [UIColor redColor];
        case 4: return [UIColor purpleColor];
    }
    
    return [UIColor blackColor];
}



- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    
    [self removeCompletedRow];
    
}



- (BOOL)removeCompletedRow {

    NSMutableArray *dropsToRemove = [NSMutableArray new];
    
    for (CGFloat y = self.gameView.bounds.size.height - DROP_SIZE.height / 2; y > 0; y -= DROP_SIZE.height) {
    
        BOOL rowIsComplete = YES;
        
        NSMutableArray *dropsFound = [NSMutableArray new];
        
        for (CGFloat x = DROP_SIZE.width / 2; x <= self.gameView.bounds.size.width - DROP_SIZE.width / 2; x += DROP_SIZE.width) {
        
            UIView *hitView = [self.gameView hitTest:CGPointMake(x, y) withEvent:NULL];
            
            if ([hitView superview] == self.gameView) {
            
                [dropsFound addObject:hitView];
                
            } else {
            
                rowIsComplete = NO;
                
                break;
                
            }
        }
        
        if (![dropsFound count]) {
            
            break;
            
        }
        
        if (rowIsComplete) {
        
            [dropsToRemove addObjectsFromArray:dropsFound];
            
        }
    }
    
    if ([dropsToRemove count]) {
    
        for (UIView *drop in dropsToRemove) {
            
            [self.dropitBehavior removeItem:drop];
            
        }
        
        [self animateRemovingDrops:dropsToRemove];
    }
    
    return NO;
}



- (void)animateRemovingDrops:(NSArray *)dropsToRemove {
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         
                         for (UIView *drop in dropsToRemove) {
                         
                             int x = (arc4random() % (int)(self.gameView.bounds.size.width*5)) - (int)self.gameView.bounds.size.width * 2;
                             
                             int y = self.gameView.bounds.size.height;
                             
                             drop.center = CGPointMake(x, y);
                             
                         }
                         
                     } completion:^(BOOL finished) {
                         
                         [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                         
                     }];
    
}



@end
