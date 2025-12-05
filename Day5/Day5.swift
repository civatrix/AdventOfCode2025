//
//  Day5.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day5: Day {
    func run(input: String) -> String {
        var ranges = Set<ClosedRange<Int>>()
        for line in input.lines {
            guard line.contains("-") else { break }
            
            let rawRange = line.bifurcate(on: "-")
            let range = Int(rawRange.0)! ... Int(rawRange.1)!
            let overlappingRanges = ranges.filter { $0.overlaps(range) }
            ranges.subtract(overlappingRanges)
            let rangeMin = min(range.lowerBound, overlappingRanges.map(\.lowerBound).min() ?? .max)
            let rangeMax = max(range.upperBound, overlappingRanges.map(\.upperBound).max() ?? .min)
            ranges.insert(rangeMin ... rangeMax)
        }
        
        return ranges.map { $0.count }.sum.description
    }
}
