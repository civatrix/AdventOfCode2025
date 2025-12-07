//
//  Day7.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day7: Day {
    func run(input: String) -> String {
        let splitters = input.parseGrid(target: "^").sorted()
        let start = input.firstIndex(of: "S")!.utf16Offset(in: input)
        var open: Set<Point> = [[start, 0]]
        var splits = Set<Point>()
        
        while let beam = open.popFirst() {
            if let splitter = splitters.first(where: { $0.x == beam.x && $0.y > beam.y }) {
                if splits.insert(splitter).inserted {
                    open.insert(splitter + .left)
                    open.insert(splitter + .right)
                }
            }
        }
        
        return splits.count.description
    }
}
