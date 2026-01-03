//
//  Day11Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day11Tests: XCTestCase {
    let day = Day11()
    
    func testDay() throws {
        let input =
"""
svr: aaa bbb
aaa: fft
fft: ccc
bbb: tty
tty: ccc
ccc: ddd eee
ddd: hub
hub: fff
eee: dac
dac: fff
fff: ggg hhh
ggg: out
hhh: out
"""
        XCTAssertEqual(day.run(input: input), "2")
    }
}
