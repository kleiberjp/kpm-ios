//
//  RestServices.m
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//
#import "AFNetworking.h"
#import "RestServices.h"
#import "UIViewController+ViewControllerExtension.h"
#import "NSString+StringExtension.h"

@implementation RestServices

@synthesize superView = _superView;
@synthesize userDefaults = _userDefaults;
@synthesize services = _services;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.services = [[DataJson alloc] init];
        self.userDefaults = [[UserDefaults alloc] init];
    }
    return self;
}

- (instancetype) initWithSuperView:(UIViewController *) view{
    self = [super init];
    if (self) {
        self.services = [[DataJson alloc] init];
        self.superView = view;
        self.userDefaults = [[UserDefaults alloc] init];
        
    }
    return self;
}

- (BOOL)loginUser:(NSString *)username withPassword:(NSString *)password{
    __block BOOL success = false;
    dispatch_group_t group = dispatch_group_create();

    NSString *URLString = [self.services getAddressLogin];
    NSDictionary *parameters = @{@"username": username, @"password": password};
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:parameters error:nil];
    [request addValue:[self.services getAppIDRestService] forHTTPHeaderField:@"X-Parse-Application-Id"];
    [request addValue:[self.services getAppKeyRestService] forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.superView showLoadingView];
    });
    
    dispatch_group_enter(group);
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *data = (NSDictionary *)responseObject;
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.superView showAlert:@"Error" withMessage:[NSString getMessageText:[data allKeys][0]]];
            });
        } else {
            success = TRUE;
            [self.userDefaults setPasswordUserIncome:password];
            [self.userDefaults setLastUserIncome:username];
            [self.userDefaults setAlreadyLoged:YES];
        }
        dispatch_group_leave(group);
    }];
    
    [dataTask resume];
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.superView hideLoadingView];
    });
    
    return success;
}


- (NSMutableArray *)getProducts{
    NSMutableArray *listProducts = [[NSMutableArray alloc] init];

    return listProducts;
}

- (BOOL)updateProducts:(NSMutableArray *)products{
    BOOL success = false;

    return success;
}

@end
