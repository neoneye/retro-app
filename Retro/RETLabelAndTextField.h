//
//  RETLabelAndTextField.h
//  Retro
//
//  Created by Simon Strandgaard on 05/03/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RETField.h"
#import "RETResetFieldProtocol.h"

@interface RETLabelAndTextField : UIView <RETResetFieldProtocol>

@property (nonatomic, strong) RETField *field;

@end
