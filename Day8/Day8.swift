//
//  Day8.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day8: Day {
    func run(input: String) -> String {
        let boxes = input.allDigits
            .chunks(ofCount: 3)
            .map { Point3D(x: $0[n: 0], y: $0[n: 1], z: $0[n: 2]) }
        let pairs = boxes.combinations(ofCount: 2)
            .map { ($0[0], $0[1]) }
            .sorted { $0.0.straightLineDistanceSquared(to: $0.1) < $1.0.straightLineDistanceSquared(to: $1.1) }
        
        var circuits = Set<Set<Point3D>>()
        for pair in pairs {
            let firstMatch = circuits.first { $0.contains(pair.0) }
            let secondMatch = circuits.first { $0.contains(pair.1) }
            
            if let firstMatch, let secondMatch {
                let combined = firstMatch.union(secondMatch)
                circuits.remove(firstMatch)
                circuits.remove(secondMatch)
                circuits.insert(combined)
            } else if let match = firstMatch ?? secondMatch {
                circuits.remove(match)
                circuits.insert(match.union([pair.0, pair.1]))
            } else {
                circuits.insert([pair.0, pair.1])
            }
            
            if circuits.count == 1 && circuits.first!.count == boxes.count {
                return (pair.0.x * pair.1.x).description
            }
        }

        return "No solution found"
    }
}
