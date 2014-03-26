//
//  RETBuilder.m
//  Retro
//
//  Created by Simon Strandgaard on 05/03/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "RETBuilder.h"
#import "RETLabelAndTextField.h"

@interface RETBuilder ()

@property (nonatomic, strong) NSMutableArray *resultViews;

@end

@implementation RETBuilder

- (id)init
{
    self = [super init];
    if (self) {
        self.resultViews = [NSMutableArray new];
    }
    return self;
}

-(void)visitPlainText:(RETFieldPlainText*)field {
	RETLabelAndTextField *view = [RETLabelAndTextField new];
	view.field = field;
	[self.resultViews addObject:view];
}

-(void)visitAmount:(RETFieldAmount*)field {
	RETLabelAndTextField *view = [RETLabelAndTextField new];
	view.field = field;
	[self.resultViews addObject:view];
}

-(void)visitDivider:(RETFieldDivider*)field {
	UIView *view = [UIView new];
	view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
	[self.resultViews addObject:view];
}

-(NSArray*)views {
	return self.resultViews.copy;
}

@end
