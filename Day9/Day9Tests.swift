//
//  Day9Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day9Tests: XCTestCase {
    let day = Day9()
    
    func testDay() throws {
        let input =
"""
7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3

"""
        XCTAssertEqual(day.run(input: input), "50")
    }
}
