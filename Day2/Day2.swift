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
            for candidate in range.map({ $0.description }) where candidate.count > 1 {
                for length in 1 ... candidate.count / 2 {
                    let prefix = String(candidate.prefix(length))
                    if String(repeating: prefix, count: candidate.count / length) == candidate {
                        sum += Int(candidate)!
                        break
                    }
                }
            }
        }
        
        return sum.description
    }
}
