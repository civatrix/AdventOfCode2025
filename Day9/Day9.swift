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

        return tiles.combinations(ofCount: 2)
            .map { tiles in
                let width = abs(tiles[0].x - tiles[1].x) + 1
                let height = abs(tiles[0].y - tiles[1].y) + 1
                return width * height
            }
            .max()!
            .description
    }
}
