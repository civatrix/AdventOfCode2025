//
//  Day3.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day3: Day {
    func run(input: String) -> String {
        return input.lines
            .map { $0.map { $0.wholeNumberValue! } }
            .map { line in
                var total = 0
                var lineSlice = line.dropFirst(0)
                for offset in (0...11).reversed() {
                    let max = lineSlice.dropLast(offset).max()!
                    lineSlice = lineSlice.dropFirst(lineSlice.firstIndex(of: max)! - lineSlice.startIndex + 1)
                    total = (total * 10) + max
                }
                
                return total
            }
            .sum
            .description
    }
}
