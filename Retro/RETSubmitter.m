//
//  RETSubmitter.m
//  Retro
//
//  Created by Simon Strandgaard on 05/03/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "RETSubmitter.h"
#import "GTMNSString+HTML.h"

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

-(void)appendLabel:(NSString*)label value:(NSString*)value {
	NSMutableString *s = [NSMutableString new];
	[s appendFormat:@"<td align='right'>%@:</td>", [label gtm_stringByEscapingForHTML]];
	[s appendString:@"<td> </td>"];
	
	if (value) {
		[s appendFormat:@"<td><b>%@</b></td>", [value gtm_stringByEscapingForHTML]];
	} else {
		[s appendString:@"<td style='color:#aaa'>empty</td>"];
	}
	
	[self.result addObject:s.copy];
}

-(void)visitPlainText:(RETFieldPlainText*)field {
	NSString *s = nil;
	if (field.textFieldValue) {
		s = [NSString stringWithFormat:@"%@", field.textFieldValue];
	}
	[self appendLabel:field.label value:s];
}

-(void)visitAmount:(RETFieldAmount*)field {
	NSString *s = nil;
	if (field.textFieldValue) {
		s = [NSString stringWithFormat:@"%@", field.textFieldValue];
	}
	[self appendLabel:field.label value:s];
}

-(void)visitDivider:(RETFieldDivider*)field {
	NSString *s = @"<td colspan='3'><hr/></td>";
	[self.result addObject:s];
}

-(NSString*)prettyString {
	NSMutableString *s = [NSMutableString new];
	[s appendString:@"<table>"];
	NSString *rows = [self.result componentsJoinedByString:@"</tr><tr>"];
	[s appendFormat:@"<tr>%@</tr>", rows];
	[s appendString:@"</table>"];
	return s.copy;
}

@end
