//
//  DishwasherTests.swift
//  JohnLewis
//
//  Created by Niall Watchorn on 14/07/2017.
//  Copyright © 2017 EpiTech. All rights reserved.
//

import XCTest
@testable import JohnLewis

class DishwasherTests: XCTestCase {
    
    func testThatItCorrectlyInitialisesFromJSON() {
        let dishwasher = Dishwasher(json: ["productId" : "1", "price" : ["now" : "225.00", "currency" : "GBP"], "title" : "Samsung AX100", "image" : "//johnlewis.scene7.com/is/image/JohnLewis/234326372?"])
        
        XCTAssertEqual(dishwasher.productId, "1")
        XCTAssertEqual(dishwasher.price.now, "225.00")
        XCTAssertEqual(dishwasher.price.currency, "GBP")
        XCTAssertEqual(dishwasher.title, "Samsung AX100")
        XCTAssertEqual(dishwasher.image, "https://johnlewis.scene7.com/is/image/JohnLewis/234326372?")
    }
}
