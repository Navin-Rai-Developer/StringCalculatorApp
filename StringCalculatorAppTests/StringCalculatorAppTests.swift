//
//  StringCalculatorAppTests.swift
//  StringCalculatorAppTests
//
//  Created by Navin Rai on 30/06/25.
//

import XCTest
@testable import StringCalculatorApp

final class CalculatorTests: XCTestCase {
    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    func testEmptyStringReturnsZero() {
        XCTAssertEqual(try calculator.add(""), 0)
    }

    func testSingleNumber() {
        XCTAssertEqual(try calculator.add("5"), 5)
    }

    func testTwoNumbers() {
        XCTAssertEqual(try calculator.add("1,2"), 3)
    }

    func testMultipleNumbers() {
        XCTAssertEqual(try calculator.add("1,2,3,4"), 10)
    }

    func testNewlineDelimiter() {
        XCTAssertEqual(try calculator.add("1\n2,3"), 6)
    }

    func testCustomDelimiter() {
        XCTAssertEqual(try calculator.add("//;\n1;2"), 3)
    }

    func testNegativeThrowsError() {
        XCTAssertThrowsError(try calculator.add("1,-2,3,-4")) { error in
            let errMsg = (error as NSError).domain
            XCTAssertTrue(errMsg.contains("-2"))
            XCTAssertTrue(errMsg.contains("-4"))
        }
    }
}
