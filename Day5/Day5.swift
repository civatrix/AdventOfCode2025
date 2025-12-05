//
//  Day5.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day5: Day {
    func run(input: String) -> String {
        var ranges = [ClosedRange<Int>]()
        var count = 0
        for line in input.lines {
            if line.contains("-") {
                let range = line.bifurcate(on: "-")
                ranges.append(Int(range.0)! ... Int(range.1)!)
            } else {
                let id = Int(line)!
                if ranges.contains(where: { $0.fastContains(id) }) {
                    count += 1
                }
            }
        }
        
        return count.description
    }
}
