//
//  Day6.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day6: Day {
    func run(input: String) -> String {
        let lines = input.lines
        
        let operators = lines.last!.split(separator: " ")
        var columns = [[Int]](repeating: [], count: operators.count)
        for line in lines {
            for (column, value) in line.allDigits.enumerated() {
                columns[column].append(value)
            }
        }
        
        var total = 0
        for (index, column) in columns.enumerated() {
            let symbol = operators[index]
            if symbol == "*" {
                total += column.reduce(1, *)
            } else if symbol == "+" {
                total += column.sum
            }
        }
        
        return total.description
    }
}
