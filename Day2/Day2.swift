//
//  Day2.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day2: Day {
    func run(input: String) -> String {
        var sum = 0
        var ranges = [ClosedRange<Int>]()
        for pair in input.split(separator: ",") {
            let pair = pair.bifurcate(on: "-")
            
            ranges.append(Int(pair.0)!...Int(pair.1)!)
        }
        
        for range in ranges {
            for candidate in range.map({ $0.description }) where candidate.count.isMultiple(of: 2) {
                if candidate.prefix(candidate.count / 2) == candidate.suffix(candidate.count / 2) {
                    sum += Int(candidate)!
                }
            }
        }
        
        return sum.description
    }
}
