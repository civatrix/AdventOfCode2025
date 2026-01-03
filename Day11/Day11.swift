//
//  Day11.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day11: Day {
    func run(input: String) -> String {
        var connections = [String: Set<String>]()
        for line in input.lines {
            let items = line.split(separator: " ").map { String($0) }
            connections[String(items[0].dropLast())] = Set(items.dropFirst())
        }
        
        return route(from: "you", connections: connections).count.description
    }
    
    func route(from: String, connections: [String: Set<String>]) -> Set<Set<String>> {
        if from == "out" { return [["out"]] }
        
        return Set(connections[from]!.flatMap { route(from: $0, connections: connections).map { $0.union([from]) } })
    }
}
