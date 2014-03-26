//
//  RETViewController.m
//  Retro
//
//  Created by Simon Strandgaard on 05/03/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "RETViewController.h"
#import "RETField.h"
#import "RETLabelAndTextField.h"
#import "RETBuilder.h"
#import "RETSubmitter.h"
#import "RETFieldLayouter.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "UIBarButtonItem+BlocksKit.h"
#import <BlocksKit/MFMailComposeViewController+BlocksKit.h>

@interface RETViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *fields;
@property (nonatomic, strong) RETBuilder *builder;
@end

@implementation RETViewController

-(void)loadView {
	self.title = @"RETRO";
	
	self.view = [UIView new];
	[self.view addSubview:self.scrollView];
	
	RETBuilder *builder = [RETBuilder new];
	for (RETField *field in self.fields) {
		[field accept:builder];
	}
	
	self.builder = builder;

	for (UIView *view in builder.views) {
		if (![view isKindOfClass:[UIView class]]) {
			continue;
		}
		[self.scrollView addSubview:view];
	}
	
	[self installNavigationBar];
}

-(void)installNavigationBar {
	__weak RETViewController *weakSelf = self;
	NSString *title = @"Submit";
	UIBarButtonItem *item = [[UIBarButtonItem alloc] bk_initWithTitle:title
																style:UIBarButtonItemStyleBordered
															  handler:^(id sender) {
																  [weakSelf submitButtonAction];
															  }];
	[self.navigationItem setRightBarButtonItem:item];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
	self.scrollView.frame = self.view.bounds;
	
	NSArray *views = self.builder.views;
	NSArray *fields = self.fields;
	NSAssert(views.count == fields.count, @"array length must be the same");
	
	CGFloat y = 10;

	RETFieldLayouter *layouter = [RETFieldLayouter new];
	NSUInteger count = fields.count;
	for (NSUInteger i=0; i<count; i++) {
		RETField *field = fields[i];
		[field accept:layouter];
		
		UIView *view = views[i];
		if (![view isKindOfClass:[UIView class]]) {
			continue;
		}
		
		CGRect b = self.view.bounds;
		b.size.height = layouter.height;
		b.origin.y = y;
		y += b.size.height + 5;
		view.frame = b;
	}
	
}

-(UIScrollView*)scrollView {
	if (!_scrollView) {
		UIScrollView *sv = [TPKeyboardAvoidingScrollView new];
		sv.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
		_scrollView = sv;
	}
	return _scrollView;
}

-(NSArray*)fields {
	if (!_fields) {
		_fields = [self defaultFields];
	}
	return _fields;
}

-(NSArray*)defaultFields {
	return @[
		// Infobox: "Problems? Call your supervisor: 51 93 29 19"
			 
		[RETFieldPlainText fieldWithName:@"Author" placeholder:@"Enter your name here"],
		[RETFieldAmount fieldWithName:@"Opening balance" placeholder:@"Todays balance"],
		[RETFieldAmount fieldWithName:@"Opening balance Dankort" placeholder:@"This amount must be zero when opening"],
		[RETFieldPlainText fieldWithName:@"Opening byttepenge ok" placeholder:@"Check the black box. Type YES if 900 kr is present."],
		[RETFieldDivider divider],
		[RETFieldAmount fieldWithName:@"Closing balance" placeholder:@"Todays balance"],
		[RETFieldAmount fieldWithName:@"Closing balance Dankort" placeholder:@"Credit card balance"],
		[RETFieldPlainText fieldWithName:@"Closing byttepenge ok" placeholder:@"Check the black box. Type YES if 900 kr is present."],
		[RETFieldAmount fieldWithName:@"Transfer to bank" placeholder:@"Amount you have placed in the safe"],
		
		// Make it taller
		[RETFieldPlainText fieldWithName:@"Comments" placeholder:@"Anything unusual"]
	];
	
	
	// Gem screenshot til kamerarulle
}

-(void)submitButtonAction {
	NSLog(@"click");

	RETSubmitter *submitter = [RETSubmitter new];
	for (RETField *field in self.fields) {
		[field accept:submitter];
	}

	NSLog(@"result: %@", submitter.prettyString);
	
	NSData *data = [submitter.prettyString dataUsingEncoding:NSUTF8StringEncoding];
	[self presentResult:data message:submitter.prettyString];
}

-(void)presentResult:(NSData*)resultData message:(NSString*)messageBody {
	NSParameterAssert(resultData);
	
	NSData *attachment0Data = resultData;
	NSString *attachment0MIME = @"application/text";
	NSString *attachment0FileName = @"TodaysReport.txt";
	NSString *subject = [NSString stringWithFormat:@"RETRO REPORT %@", [NSDate new]];
	MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
	[mailer setToRecipients:@[@"bestyrer@retro-norrebro.dk"]];
	mailer.bk_completionBlock = ^(MFMailComposeViewController *vc, MFMailComposeResult result, NSError *error) {
		NSLog(@"dismissed mail compose view controller");
		if (error) {
			NSLog(@"error occurred %@", error);
			return;
		}
		switch (result) {
			case MFMailComposeResultSent:
				NSLog(@"Sent");
				break;
			case MFMailComposeResultCancelled:
				NSLog(@"Cancelled");
				break;
			default:
				NSLog(@"Other");
				break;
		}
	};
	[mailer setSubject:subject];
	[mailer setMessageBody:messageBody isHTML:NO];
	[mailer addAttachmentData:attachment0Data mimeType:attachment0MIME fileName:attachment0FileName];
	[self presentViewController:mailer animated:YES completion:NULL];
}

@end
