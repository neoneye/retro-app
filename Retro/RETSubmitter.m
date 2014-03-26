//
//  RETSubmitter.m
//  Retro
//
//  Created by Simon Strandgaard on 05/03/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "RETSubmitter.h"

@interface RETSubmitter ()

@property (nonatomic, strong) NSMutableArray *result;

@end

@implementation RETSubmitter

- (id)init
{
    self = [super init];
    if (self) {
        self.result = [NSMutableArray new];
    }
    return self;
}

-(void)visitPlainText:(RETFieldPlainText*)field {
	NSString *s = [NSString stringWithFormat:@"plain text: %@", field.textFieldValue];
	[self.result addObject:s];
}

-(void)visitAmount:(RETFieldAmount*)field {
	NSString *s = [NSString stringWithFormat:@"amount: %@", field.textFieldValue];
	[self.result addObject:s];
}

-(void)visitDivider:(RETFieldDivider*)field {
	// do nothing
}

-(NSString*)prettyString {
	return [self.result componentsJoinedByString:@"\n"];
}

@end
