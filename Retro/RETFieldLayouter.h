//
//  RETFieldLayouter.h
//  Retro
//
//  Copyright (c) 2014 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RETField.h"

@interface RETFieldLayouter : NSObject <RETFieldVisitor>

@property (nonatomic, readonly) NSInteger height;

+(RETFieldLayouter*)layouter;

@end
