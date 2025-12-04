//
//  Day4.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day4: Day {
    func run(input: String) -> String {
        var grid = input.parseGrid(target: "@")
        var toRemove: Set<Point> = []
        var removed = 0
        
        repeat {
            toRemove = grid.filter { cell in
                grid.intersection(cell.neighbours).count < 4
            }
            removed += toRemove.count
            grid.subtract(toRemove)
        } while !toRemove.isEmpty
                    
        return removed.description
    }
}
