//
//  Day6Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day6Tests: XCTestCase {
    let day = Day6()
    
    func testDay() throws {
        let input =
"""
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
"""
        XCTAssertEqual(day.run(input: input), "4277556")
    }
}
