//
//  RETTextField.m
//  Retro
//
//  Created by Simon Strandgaard on 19/03/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "RETTextField.h"

@implementation RETTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
	return CGRectInset( bounds , 10 , 10 );
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
	return CGRectInset( bounds , 10 , 10 );
}

@end
