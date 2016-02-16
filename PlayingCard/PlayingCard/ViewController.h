//
//  ViewController.h
//  PlayingCard
//
//  Created by Pavlo Cretsu on 11/19/15.
//  Copyright © 2015 Pasha Cretsu. All rights reserved.
//
// Abstract class. Must implement methods ad described bellow

@import UIKit;

#import "Deck.h"

@interface ViewController : UIViewController

// protected
// for subclasses
- (Deck *)createDeck; //abstract

@end

