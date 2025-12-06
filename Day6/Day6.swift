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
        var columns = [[Character]](repeating: [], count: lines.first!.count)
        for line in lines.dropLast() {
            for (column, value) in line.enumerated() {
                columns[column].append(value)
            }
        }
        
        let space = Array<Character>(repeating: " ", count: lines.count - 1)
        var total = 0
        for (index, column) in columns.split(separator: space).enumerated() {
            let numbers = column.map { Int(String($0).trimmingCharacters(in: .whitespaces))! }
            let symbol = operators[index]
            if symbol == "*" {
                total += numbers.reduce(1, *)
            } else if symbol == "+" {
                total += numbers.sum
            }
        }
        
        return total.description
    }
}
