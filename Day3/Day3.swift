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
                let max = line.dropLast().max()!
                let maxIndex = line.firstIndex(of: max)!
                let nextMax = line.suffix(from: maxIndex + 1).max()!
                
                return max * 10 + nextMax
            }
            .sum
            .description
    }
}
