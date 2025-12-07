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
        
        var cache: [Point: Int] = [:]
        func paths(from beam: Point) -> Int {
            if let cacheHit = cache[beam] {
                return cacheHit
            }
            
            let total: Int
            if let splitter = splitters.first(where: { $0.x == beam.x && $0.y > beam.y }) {
                total = paths(from: splitter + .left) + paths(from: splitter + .right)
            } else {
                total = 1
            }
            
            cache[beam] = total
            return total
        }
        
        let final = paths(from: [start, 0]).description
        return final
    }
}
