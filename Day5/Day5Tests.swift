//
//  Day5Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day5Tests: XCTestCase {
    let day = Day5()
    
    func testDay() throws {
        let input =
"""
3-5
10-14
16-20
12-18

1
5
8
11
17
32
"""
        XCTAssertEqual(day.run(input: input), "14")
    }
}
