//
//  UserDefaults.m
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "UserDefaults.h"
#import "NSString+StringExtension.h"
@import RNCryptor;

@implementation UserDefaults

static NSString *LAST_USER_INGRESED = @"UD_LAST_USER_INGRESED";
static NSString *REMEMBER_USER = @"UD_ALREADY_LOGED";
static NSString *PASSWORD_USER = @"UD_PASSWORD_USER";
static NSString *APP_VERSION = @"UD_APP_VERSION";
static NSString *LIST_PRODUCTS = @"UD_LIST_PRODUCTS";
static NSString *LIST_PRODUCTS_TO_UPDATE = @"UD_LIST_PRODUCTS_TO_UPDATE";

static NSString *passwordEncrypt = @"jgCKT39YDuKt5Sz6";

-(NSString *)getLastUserIncome{
    NSUserDefaults *user_defaults = [self getUserDefaults];
    NSData *userData = [user_defaults objectForKey:LAST_USER_INGRESED];
    if (userData != nil) {
        userData = [RNCryptor decryptData:userData password:passwordEncrypt error:nil];
        
        NSString *user = [[NSString alloc] initWithData:userData encoding:NSUTF8StringEncoding];
        if ([NSString isEmpty:user]) {
            return @"";
        }
        return user;
    }
    
    return @"";
}

-(void)setLastUserIncome:(NSString *)user{
    NSUserDefaults *user_defaults = [self getUserDefaults];
    NSData *userData = [user dataUsingEncoding:NSUTF8StringEncoding];
    userData = [RNCryptor encryptData:userData password:passwordEncrypt];
    
    [user_defaults setObject:userData forKey:LAST_USER_INGRESED];
    [user_defaults synchronize];
}

-(NSString *)getPasswordUserIncome
{
    NSUserDefaults *user_defaults = [self getUserDefaults];
    NSData *passwordData = [user_defaults objectForKey:PASSWORD_USER];
    if (passwordData != nil) {
        passwordData = [RNCryptor decryptData:passwordData password:passwordEncrypt error:nil];
        
        NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        if ([NSString isEmpty:password]) {
            return @"";
        }
        return password;
    }
    
    return @"";
}

-(void)setPasswordUserIncome:(NSString *)password
{
    NSUserDefaults *user_defaults = [self getUserDefaults];
    
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    passwordData = [RNCryptor encryptData:passwordData password:passwordEncrypt];
    
    [user_defaults setObject:passwordData forKey:PASSWORD_USER];
    [user_defaults synchronize];
}

-(BOOL)isAlreadyLoged
{
    NSUserDefaults *user_defaults = [self getUserDefaults];
    BOOL remember_user = [user_defaults boolForKey:REMEMBER_USER];
    return remember_user;
}

-(void)setAlreadyLoged:(BOOL)remember
{
    NSUserDefaults *user_defaults = [self getUserDefaults];
    [user_defaults setBool:remember forKey:REMEMBER_USER];
    [user_defaults synchronize];
}

- (NSMutableArray *)getListProduct{
    NSUserDefaults *user_defaults = [self getUserDefaults];
    NSData *data = [user_defaults objectForKey:LIST_PRODUCTS];
    NSArray *items = [[NSArray alloc] init];
    if (data != nil){
        data = [RNCryptor decryptData:data password:passwordEncrypt error:nil];
        items = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    NSMutableArray *list_products = [NSMutableArray arrayWithArray:items];
    return list_products;
}


- (void)setListProducts:(NSMutableArray *)products{
    NSData *listObject = [NSKeyedArchiver archivedDataWithRootObject:products];
    listObject = [RNCryptor encryptData:listObject password:passwordEncrypt];
    NSUserDefaults *user_defaults = [self getUserDefaults];
    [user_defaults setObject:listObject forKey:LIST_PRODUCTS];
    [user_defaults synchronize];
}


- (NSMutableArray *)getListProductToUpdate{
    NSUserDefaults *user_defaults = [self getUserDefaults];
    NSData *data = [user_defaults objectForKey:LIST_PRODUCTS_TO_UPDATE];
    NSArray *items = [[NSArray alloc] init];
    if (data != nil){
        data = [RNCryptor decryptData:data password:passwordEncrypt error:nil];
        items = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    NSMutableArray *list_products = [NSMutableArray arrayWithArray:items];
    return list_products;
}


- (void)setListProductsToUpdate:(NSMutableArray *)products{
    NSData *listObject = [NSKeyedArchiver archivedDataWithRootObject:products];
    listObject = [RNCryptor encryptData:listObject password:passwordEncrypt];
    NSUserDefaults *user_defaults = [self getUserDefaults];
    [user_defaults setObject:listObject forKey:LIST_PRODUCTS_TO_UPDATE];
    [user_defaults synchronize];
}


-(NSUserDefaults *)getUserDefaults
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return userDefaults;
}

-(double)getAppVersion{
    double appversion = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] doubleValue];
    return appversion;
}


@end
