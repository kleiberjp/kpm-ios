//
//  UserDefaults.h
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

-(NSString *)getLastUserIncome;
-(void)setLastUserIncome:(NSString *)user;

-(NSString *)getPasswordUserIncome;
-(void)setPasswordUserIncome:(NSString *)password;

-(NSMutableArray *)getListProduct;
-(void)setListProducts:(NSMutableArray *)products;

-(NSMutableArray *)getListProductToUpdate;
-(void)setListProductsToUpdate:(NSMutableArray *)products;

-(BOOL)isAlreadyLoged;
-(void)setAlreadyLoged:(BOOL)remember;

@end
