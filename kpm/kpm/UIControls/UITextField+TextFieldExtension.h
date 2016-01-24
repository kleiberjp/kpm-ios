//
//  UITextField+TextFieldExtension.h
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (TextFieldExtension)

@property(retain, nonatomic) IBOutlet UILabel *label_error;

- (void)setError:(NSString *)error;
- (void)removeErrors;

@end
