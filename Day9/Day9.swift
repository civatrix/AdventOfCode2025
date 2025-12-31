//
//  Day9.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day9: Day {
    func run(input: String) -> String {
        let tiles = input.allDigits.chunks(ofCount: 2).map { Point(x: $0[n: 0], y: $0[n: 1]) }
        let compressed = tiles.compressPoints()

        var filled = Set<Point>()
        for index in compressed.indices {
            let start = compressed[index]
            let end = compressed[(index + 1) % compressed.count]

            if start.x == end.x {
                for y in min(start.y, end.y)...max(start.y, end.y) {
                    filled.insert([start.x, y])
                }
            } else if start.y == end.y {
                for x in min(start.x, end.x)...max(start.x, end.x) {
                    filled.insert([x, start.y])
                }
            } else {
                fatalError("Points are colinear (\(index)): \(start), \(end)")
            }
        }

        var start: Point?
        let boundsX = filled.map(\.x).minAndMax()!
        let boundsY = filled.map(\.y).minAndMax()!
        for candidate in compressed {
            for point in candidate.neighbours where !compressed.contains(point) {
                var left = 0, right = 0, above = 0, below = 0
                var previous = false
                for x in point.x...boundsX.max + 1 {
                    let current = filled.contains([x, point.y])
                    if previous != current {
                        right += 1
                    }
                    previous = current
                }

                previous = false
                for x in boundsX.min - 1...point.x {
                    let current = filled.contains([x, point.y])
                    if previous != current {
                        left += 1
                    }
                    previous = current
                }

                previous = false
                for y in point.y...boundsY.max + 1 {
                    let current = filled.contains([point.x, y])
                    if previous != current {
                        below += 1
                    }
                    previous = current
                }

                previous = false
                for y in boundsY.min - 1...point.y {
                    let current = filled.contains([point.x, y])
                    if previous != current {
                        above += 1
                    }
                    previous = current
                }

                guard left > 0, right > 0, above > 0, below > 0 else {
                    continue
                }

                if (left / 2).isMultiple(of: 2) || (right / 2).isMultiple(of: 2) || (above / 2).isMultiple(of: 2) || (below / 2).isMultiple(of: 2) {
                    continue
                } else {
                    start = point
                    break
                }
            }
        }

        guard let start else {
            fatalError("Unable to find start of fill")
        }

        var queue = Set<Point>([start])
        while let next = queue.popFirst() {
            filled.insert(next)
            queue.formUnion(next.adjacent.filter { !filled.contains($0) })
        }

        return tiles.indices.combinations(ofCount: 2)
            .filter { indices in
                let tiles = [compressed[indices[0]], compressed[indices[1]]]
                let (minX, maxX) = tiles.map(\.x).minAndMax()!
                let (minY, maxY) = tiles.map(\.y).minAndMax()!
                for x in minX...maxX {
                    if !filled.contains([x, minY]) || !filled.contains([x, maxY]) {
                        return false
                    }
                }

                for y in minY...maxY {
                    if !filled.contains([minX, y]) || !filled.contains([maxX, y]) {
                        return false
                    }
                }

                return true
            }
            .map { indices in
                let width = abs(tiles[indices[0]].x - tiles[indices[1]].x) + 1
                let height = abs(tiles[indices[0]].y - tiles[indices[1]].y) + 1
                return width * height
            }
            .max()!
            .description
    }
}
