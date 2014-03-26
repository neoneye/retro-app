//
//  RETLabelAndTextField.m
//  Retro
//
//  Created by Simon Strandgaard on 05/03/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "RETLabelAndTextField.h"
#import "RETTextField.h"

@interface RETLabelAndTextField () <UITextFieldDelegate, RETFieldVisitor>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic) BOOL restrictToMax8Digits;

@end


@implementation RETLabelAndTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self sharedInit];
    }
    return self;
}

-(void)sharedInit {
	[self addSubview:self.label];
	[self addSubview:self.textField];
}

-(void)layoutSubviews {
	[super layoutSubviews];
	
	CGFloat width = 400;
	
	CGRect r = self.bounds;
	CGRect slice, remainder;
	CGRectDivide(r, &slice, &remainder, width, CGRectMinXEdge);

	CGRect labelFrame = CGRectInset(slice, 5.0f, 0.f);
	CGRect textFieldFrame = CGRectInset(remainder, 5.0f, 0.f);

	self.label.frame = labelFrame;
	self.textField.frame = textFieldFrame;
}

-(UILabel*)label {
	if (!_label) {
		UILabel *label = [UILabel new];
		label.text = @"label";
		label.textColor = [UIColor blackColor];
		label.textAlignment = NSTextAlignmentRight;
		[label setFont:[UIFont systemFontOfSize:30]];
		_label = label;
	}
	return _label;
}

-(UITextField*)textField {
	if (!_textField) {
		UITextField *tf = [RETTextField new];
		tf.placeholder = @"textfield";
		tf.backgroundColor = [UIColor whiteColor];
		tf.delegate = self;
		_textField = tf;
	}
	return _textField;
}

- (void)sync {
	self.field.textFieldValue = self.textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self sync];
	return NO;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	[self sync];
	return YES;
}

-(void)setField:(RETField *)field {
	_field = field;
	[field accept:self];
}

-(void)visitPlainText:(RETFieldPlainText*)field {
	self.label.text = field.label;
	self.textField.placeholder = field.placeholder;
	self.textField.keyboardType = UIKeyboardTypeDefault;
	self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
	self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	self.restrictToMax8Digits = NO;
}

-(void)visitAmount:(RETFieldAmount*)field {
	self.label.text = field.label;
	self.textField.placeholder = field.placeholder;
	self.textField.keyboardType = UIKeyboardTypeDecimalPad;
	self.restrictToMax8Digits = YES;
}

-(void)visitDivider:(RETFieldDivider*)field {
	// do nothing
}

-(void)ret_resetField {
	self.textField.text = nil;
}

#define NUMBERS_ONLY @"1234567890"
#define CHARACTER_LIMIT 8

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
	if (self.restrictToMax8Digits) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT));
	}
	
	return YES;
}

@end
