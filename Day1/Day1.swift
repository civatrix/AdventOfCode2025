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
            
            let originalDial = dial
            dial += (number % 100) * direction
            dial = (dial + 100) % 100
            total += number / 100
            
            if originalDial == 0 {
                continue
            }
            if dial == 0 || (dial < originalDial && direction == 1) || (dial > originalDial && direction == -1) {
                total += 1
            }
        }
        
        return total.description
    }
}
