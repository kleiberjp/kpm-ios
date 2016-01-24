//
//  NSString+StringExtension.h
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringExtension)

+(BOOL) isEmpty:(NSString *)string;
-(BOOL)stringIsValidEmailAddress;
-(NSString *) getMessage;
+(NSString *) getMessageText: (NSString *) findMessage;
+(NSString *) getMessageTextError:(NSString *)findMessage;


@end
