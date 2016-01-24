//
//  kpmTests.m
//  kpmTests
//
//  Created by Kleiber J Perez on 23/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DataJson.h"

@interface kpmTests : XCTestCase

@end

@implementation kpmTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

-(void) testOpenFileReadData{
    DataJson *data = [[DataJson alloc] init];
    NSString *urlservices = [data getUrlServices];
    NSString *appId = [data getAppIDRestService];
    NSString *appKey = [data getAppKeyRestService];
    NSString *urlLogin = [data getAddressLogin];
    NSString *urlList = [data getAddressListProducts];
    NSString *urlUpdate = [data getAddressUpdateProduct];

    NSLog(@"%@, %@, %@, %@, %@, %@, ", urlservices, appId, appKey, urlLogin, urlList, urlUpdate);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
