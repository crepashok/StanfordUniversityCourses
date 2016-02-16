//
//  DropitBehavior.h
//  Dropit
//
//  Created by Pavlo Cretsu on 2/15/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

@import UIKit;


@interface DropitBehavior : UIDynamicBehavior

- (void)addItem:(id <UIDynamicItem>)item;

- (void)removeItem:(id <UIDynamicItem>)item;

@end
