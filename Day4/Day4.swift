//
//  Day4.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day4: Day {
    func run(input: String) -> String {
        let grid = input.parseGrid(target: "@")
        return grid.map { cell in
            grid.intersection(cell.neighbours).count < 4 ? 1 : 0
        }
        .sum
        .description
    }
}
