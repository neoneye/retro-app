//
//  RETField.h
//  Retro
//
//  Created by Simon Strandgaard on 05/03/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RETFieldPlainText;
@class RETFieldAmount;
@class RETFieldDivider;


@protocol RETFieldVisitor <NSObject>

@required

-(void)visitPlainText:(RETFieldPlainText*)field;
-(void)visitAmount:(RETFieldAmount*)field;
-(void)visitDivider:(RETFieldDivider*)field;

@end


@interface RETField : NSObject

@property (nonatomic, strong) NSString *textFieldValue;

-(void)accept:(NSObject <RETFieldVisitor> *)visitor;

@end


@interface RETFieldPlainText : RETField

@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *placeholder;

+(RETFieldPlainText*)fieldWithName:(NSString*)label placeholder:(NSString*)placeholder;

@end


@interface RETFieldAmount : RETField

@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *placeholder;

+(RETFieldAmount*)fieldWithName:(NSString*)label placeholder:(NSString*)placeholder;

@end


@interface RETFieldDivider : RETField

+(RETFieldDivider*)divider;

@end
