//
//  RETFieldLayouter.m
//  Retro
//
//  Copyright (c) 2014 None. All rights reserved.
//

#import "RETFieldLayouter.h"

@interface RETFieldLayouter ()

@property (nonatomic, assign) NSInteger height;

@end

@implementation RETFieldLayouter

+(RETFieldLayouter*)layouter {
	RETFieldLayouter *layouter = [RETFieldLayouter new];
	layouter.height = 0;
	return layouter;
}

-(void)visitPlainText:(RETFieldPlainText*)field {
	self.height = 60;
}

-(void)visitAmount:(RETFieldAmount*)field {
	self.height = 60;
}

-(void)visitDivider:(RETFieldDivider*)field {
	self.height = 1;
}

@end
