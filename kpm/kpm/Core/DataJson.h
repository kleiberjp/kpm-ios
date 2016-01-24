//
//  DataJson.h
//  kpm
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataJson : NSObject{
    NSString *_urlServices;
}

#pragma general urls

-(NSString *) getUrlServices;
-(NSString *) getAddressLogin;
-(NSString *) getAppIDRestService;
-(NSString *) getAppKeyRestService;


#pragma urls Products

-(NSString *) getAddressListProducts;
-(NSString *) getAddressUpdateProduct;
@end
