//
//  ProductItem.m
//
//  Created by Kleiber Perez on 23/01/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ProductItem.h"


NSString *const kProductItemQuantity = @"quantity";
NSString *const kProductItemPrice = @"price";
NSString *const kProductItemObjectId = @"objectId";
NSString *const kProductItemUpdatedAt = @"updatedAt";
NSString *const kProductItemImageURL = @"imageURL";
NSString *const kProductItemCreatedAt = @"createdAt";
NSString *const kProductItemName = @"name";


@interface ProductItem ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProductItem

@synthesize quantity = _quantity;
@synthesize price = _price;
@synthesize objectId = _objectId;
@synthesize updatedAt = _updatedAt;
@synthesize imageURL = _imageURL;
@synthesize createdAt = _createdAt;
@synthesize name = _name;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.quantity = [self objectOrNilForKey:kProductItemQuantity fromDictionary:dict];
            self.price = [self objectOrNilForKey:kProductItemPrice fromDictionary:dict];
            self.objectId = [self objectOrNilForKey:kProductItemObjectId fromDictionary:dict];
            self.updatedAt = [self objectOrNilForKey:kProductItemUpdatedAt fromDictionary:dict];
            self.imageURL = [self objectOrNilForKey:kProductItemImageURL fromDictionary:dict];
            self.createdAt = [self objectOrNilForKey:kProductItemCreatedAt fromDictionary:dict];
            self.name = [self objectOrNilForKey:kProductItemName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.quantity forKey:kProductItemQuantity];
    [mutableDict setValue:self.price forKey:kProductItemPrice];
    [mutableDict setValue:self.objectId forKey:kProductItemObjectId];
    [mutableDict setValue:self.updatedAt forKey:kProductItemUpdatedAt];
    [mutableDict setValue:self.imageURL forKey:kProductItemImageURL];
    [mutableDict setValue:self.createdAt forKey:kProductItemCreatedAt];
    [mutableDict setValue:self.name forKey:kProductItemName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.quantity = [aDecoder decodeObjectForKey:kProductItemQuantity];
    self.price = [aDecoder decodeObjectForKey:kProductItemPrice];
    self.objectId = [aDecoder decodeObjectForKey:kProductItemObjectId];
    self.updatedAt = [aDecoder decodeObjectForKey:kProductItemUpdatedAt];
    self.imageURL = [aDecoder decodeObjectForKey:kProductItemImageURL];
    self.createdAt = [aDecoder decodeObjectForKey:kProductItemCreatedAt];
    self.name = [aDecoder decodeObjectForKey:kProductItemName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_quantity forKey:kProductItemQuantity];
    [aCoder encodeObject:_price forKey:kProductItemPrice];
    [aCoder encodeObject:_objectId forKey:kProductItemObjectId];
    [aCoder encodeObject:_updatedAt forKey:kProductItemUpdatedAt];
    [aCoder encodeObject:_imageURL forKey:kProductItemImageURL];
    [aCoder encodeObject:_createdAt forKey:kProductItemCreatedAt];
    [aCoder encodeObject:_name forKey:kProductItemName];
}

- (id)copyWithZone:(NSZone *)zone
{
    ProductItem *copy = [[ProductItem alloc] init];
    
    if (copy) {

        copy.quantity = [self.quantity copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.objectId = [self.objectId copyWithZone:zone];
        copy.updatedAt = [self.updatedAt copyWithZone:zone];
        copy.imageURL = [self.imageURL copyWithZone:zone];
        copy.createdAt = [self.createdAt copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
