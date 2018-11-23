//
//  BskyResidentsUITests.m
//  BskyResidentsUITests
//
//  Created by 罗林轩 on 2017/12/21.
//  Copyright © 2017年 罗林轩. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface BskyResidentsUITests : XCTestCase

@end

@implementation BskyResidentsUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    [tabBarsQuery.buttons[@"\u5065\u5eb7"] tap];
    [tabBarsQuery.buttons[@"\u6d88\u606f"] tap];
    [tabBarsQuery.buttons[@"\u6211\u7684"] tap];
    
//    XCUIElementQuery *tablesQuery = app.tables;
//    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"\U6211\U7684\U8ba2\U5355"]/*[[".cells.staticTexts[@\"\\U6211\\U7684\\U8ba2\\U5355\"]",".staticTexts[@\"\\U6211\\U7684\\U8ba2\\U5355\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
//    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"\U547c\U533b\U54a8\U8be2"]/*[[".cells.staticTexts[@\"\\U547c\\U533b\\U54a8\\U8be2\"]",".staticTexts[@\"\\U547c\\U533b\\U54a8\\U8be2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];

}

@end
