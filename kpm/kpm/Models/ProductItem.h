//
//  ProductItem.h
//
//  Created by Kleiber Perez on 23/01/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ProductItem : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *quantity;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *updatedAt;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end