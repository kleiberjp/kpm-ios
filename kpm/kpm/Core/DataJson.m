//
//  DataJson.m
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "DataJson.h"
@import RNCryptor;

@implementation DataJson

-(id)init{
    self = [super init];
    if (self) {
        _urlServices = [self getUrlServices];
    }
    return self;
}

#pragma methods generals rest services

-(NSString *) getUrlServices{
    return [self getValueFor:@"url_service"];
}

-(NSString *) getAddressLogin{
    return [_urlServices stringByAppendingString:[self getValueFor:@"login" inSection:@"services"]];
}

- (NSString *)getAppIDRestService{
    return [self getValueFor:@"rest_app_id"];
}

- (NSString *)getAppKeyRestService{
    return [self getValueFor:@"rest_app_key"];
}


#pragma methods other services

- (NSString *)getAddressListProducts{
    return [_urlServices stringByAppendingString:[self getValueFor:@"products" inSection:@"services"]];
}


- (NSString *)getAddressUpdateProduct{
    return [_urlServices stringByAppendingString:[self getValueFor:@"update" inSection:@"services"]];
}


#pragma methods general use

-(NSString *) getValueFor:(NSString *)key{
    NSDictionary *data = [self readFile];
    if (data) return [data valueForKey:key];
    return @"";
}

-(NSString *) getValueFor:(NSString *)key inSection:(NSString *)section{
    NSDictionary *data = [self readFile];
    
    if(data) return [[data objectForKey:section] valueForKey:key];
    return @"";
}

-(NSDictionary *) readFile{
    NSError *error;
    NSString *ruta  = [[NSBundle mainBundle] pathForResource:@"connection" ofType:@"json"];
    NSString *dataArchivo = [[NSString alloc] initWithContentsOfFile:ruta encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [dataArchivo dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    return resultado;
}



@end
