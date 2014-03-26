//
//  RETSubmitter.h
//  Retro
//
//  Created by Simon Strandgaard on 05/03/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RETField.h"

@interface RETSubmitter : NSObject <RETFieldVisitor>

-(NSString*)prettyString;

@end
