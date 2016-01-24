//
//  NSString+StringExtension.m
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "NSString+StringExtension.h"

@implementation NSString (StringExtension)

+(BOOL) isEmpty:(NSString *)string
{
    BOOL empty = ( string == nil ||
                  [string isKindOfClass:[NSNull class]] ||
                  ([string respondsToSelector:@selector(length)] && [(NSData *)string length] == 0) ||
                  ([string respondsToSelector:@selector(count)] && [(NSArray *)string count] == 0));
    return empty;
}

- (BOOL)stringIsValidEmailAddress {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

-(NSString *) getMessage {
    
    return NSLocalizedString(self, self);
}

+(NSString *) getMessageText: (NSString *) findMessage {
    return NSLocalizedString(findMessage, findMessage);
}

+(NSString *) getMessageTextError:(NSString *)findMessage{
    return [[NSString alloc] initWithFormat:@"* %@", NSLocalizedString(findMessage, findMessage)];
}

@end
