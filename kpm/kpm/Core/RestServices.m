#import "AFNetworking.h"
#import "NSString+StringExtension.h"
#import "ProductItem.h"
#import "RestServices.h"
#import "UIViewController+ViewControllerExtension.h"

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
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:parameters error:nil];
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
                [self.superView showAlert:@"Error" withMessage:[NSString getMessageText:[data objectForKey:@"error"]]];
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
    dispatch_group_t group = dispatch_group_create();

    
    NSString *URLString = [self.services getAddressListProducts];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:nil error:nil];
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
                [self.superView showAlert:@"Error" withMessage:[NSString getMessageText:[data objectForKey:@"error"]]];
            });
        } else {
            data = data[@"results"];
            for (NSDictionary *item in data) {
                ProductItem *product = [[ProductItem alloc] initWithDictionary:item];
                [listProducts addObject:product];
            }
            
            [self.userDefaults setListProducts:listProducts];
        }
        dispatch_group_leave(group);
    }];
    
    [dataTask resume];
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.superView hideLoadingView];
    });

    return listProducts;
}

- (void)updateProducts{
    NSMutableArray *listProducts = [self.userDefaults getListProductToUpdate];
    NSMutableArray *discardedItems = [NSMutableArray array];

    __block int errors;
    
    if (listProducts == nil || listProducts.count == 0) {
    
        [self.superView showAlert:@"Awesome" withMessage:[NSString getMessageText:@"no-products-update"]];
    
    }else{
        dispatch_group_t group = dispatch_group_create();

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.superView showLoadingView];
        });
        
        for (NSDictionary *item in listProducts) {
            NSString *URLString = [NSString stringWithFormat:[self.services getAddressUpdateProduct], item[@"idProduct"]];
            NSDictionary *parameters = @{@"quantity": item[@"quantity"]};

            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
            manager.securityPolicy.allowInvalidCertificates = YES;
            NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"PUT" URLString:URLString parameters:parameters error:nil];
            
            [request addValue:[self.services getAppIDRestService] forHTTPHeaderField:@"X-Parse-Application-Id"];
            [request addValue:[self.services getAppKeyRestService] forHTTPHeaderField:@"X-Parse-REST-API-Key"];
            
            dispatch_group_enter(group);
            NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                        completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                
                                                            if (error) {
                                                                errors++;
                                                            } else {
                                                                [discardedItems addObject:item];
                                                            }
                                                            dispatch_group_leave(group);
                                                        }
                                              ];
            
            [dataTask resume];
            
        }

        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.superView hideLoadingView];
                
                NSString *message = (errors == 0) ? [NSString getMessageText:@"message-success-update"] : [NSString stringWithFormat:[NSString getMessageText:@"message-wrong-update"], errors];
                NSString *title = (errors == 0) ? [NSString getMessageText:@"title-success"] : @"Oops";
                [self.superView showAlert:title withMessage:message];
                
                [listProducts removeObjectsInArray:discardedItems];
                [self.userDefaults setListProductsToUpdate:listProducts];
            });
        });
    }
}

@end
