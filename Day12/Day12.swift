//
//  Day12.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day12: Day {
    func run(input: String) -> String {
        return input.lines
            .filter { $0.contains("x") }
            .map { $0.allDigits }
            .filter { $0[0] * $0[1] >= $0.dropFirst(2).sum * 9 }
            .count
            .description
    }
}
