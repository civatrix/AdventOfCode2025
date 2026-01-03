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
        
        let serverToDac = routes(from: "svr", to: "dac", connections: connections)
        let dacToFft = routes(from: "dac", to: "fft", connections: connections)
        let fftToOut = routes(from: "fft", to: "out", connections: connections)
        let serverToFft = routes(from: "svr", to: "fft", connections: connections)
        let fftToDac = routes(from: "fft", to: "dac", connections: connections)
        let dacToOut = routes(from: "dac", to: "out", connections: connections)
        
        return ((serverToDac * dacToFft * fftToOut) + (serverToFft * fftToDac * dacToOut)).description
    }
    
    var cache: [String: [String: Int]] = [:]
    func routes(from: String, to: String, connections: [String: Set<String>]) -> Int {
        if let cacheHit = cache[from]?[to] {
            return cacheHit
        }
        
        if from == to { return 1 }
        
        let result = connections[from, default: []].map { routes(from: $0, to: to, connections: connections) }.sum
        cache[from, default: [:]][to] = result
        return result
    }
}
