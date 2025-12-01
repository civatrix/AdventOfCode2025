//
//  Day1.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day1: Day {
    func run(input: String) -> String {
        var dial = 50
        var total = 0
        for line in input.lines {
            let number = line.allDigits[0]
            let direction = line.first == "R" ? 1 : -1
            dial += number * direction
            dial = (dial + 100) % 100
            if dial == 0 {
                 total += 1
            }
        }
        
        return total.description
    }
}
