//
//  Day3Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day3Tests: XCTestCase {
    let day = Day3()
    
    func testDay() throws {
        let input =
"""
987654321111111
811111111111119
234234234234278
818181911112111
"""
        XCTAssertEqual(day.run(input: input), "357")
    }
}
