//
//  RETField.m
//  Retro
//
//  Created by Simon Strandgaard on 05/03/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "RETField.h"

@implementation RETField

-(void)accept:(NSObject <RETFieldVisitor> *)visitor {
	NSAssert(NO, @"must be invoked by subclass");
}

@end


@implementation RETFieldPlainText

-(void)accept:(NSObject <RETFieldVisitor> *)visitor {
	[visitor visitPlainText:self];
}

+(RETFieldPlainText*)fieldWithName:(NSString*)label placeholder:(NSString*)placeholder {
	RETFieldPlainText *f = [RETFieldPlainText new];
	f.label = label;
	f.placeholder = placeholder;
	return f;
}

@end


@implementation RETFieldAmount

-(void)accept:(NSObject <RETFieldVisitor> *)visitor {
	[visitor visitAmount:self];
}

+(RETFieldAmount*)fieldWithName:(NSString*)label placeholder:(NSString*)placeholder {
	RETFieldAmount *f = [RETFieldAmount new];
	f.label = label;
	f.placeholder = placeholder;
	return f;
}

@end


@implementation RETFieldDivider

-(void)accept:(NSObject <RETFieldVisitor> *)visitor {
	[visitor visitDivider:self];
}

+(RETFieldDivider*)divider {
	return [RETFieldDivider new];
}

@end
