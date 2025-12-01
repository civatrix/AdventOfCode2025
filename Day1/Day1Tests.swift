//
//  Day1Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day1Tests: XCTestCase {
    let day = Day1()
    
    func testDay() throws {
        let input =
"""
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
"""
        XCTAssertEqual(day.run(input: input), "6")
    }
}
