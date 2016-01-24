//
//  RestServices.h
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DataJson.h"
#import "UserDefaults.h"

@interface RestServices : NSObject

@property (nonatomic, strong) DataJson *services;
@property (nonatomic, retain) UIViewController *superView;
@property(retain, nonatomic) UserDefaults  *userDefaults;

- (BOOL) loginUser:(NSString *)username withPassword:(NSString *)password;
- (NSMutableArray *) getProducts;
- (BOOL) updateProducts:(NSMutableArray *)products;

@end
