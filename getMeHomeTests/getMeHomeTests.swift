//
//  getMeHomeTests.swift
//  getMeHomeTests
//
//  Created by Nate Perry on 2/2/16.
//  Copyright © 2016 Nate Perry. All rights reserved.
//

import XCTest
@testable import getMeHome

class getMeHomeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetFrontrunnerRoute() {
        let expectation = expectationWithDescription("getRoute")
        NetworkController.getRoute(.r750) { response in
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(1000.0) { error in
            if let _ = error {
                print("timeout error: \(error)")
            }
        }
    }
    
}
