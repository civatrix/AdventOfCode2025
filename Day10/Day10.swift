//
//  Day10.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation
import RegexBuilder

final class Day10: Day {
    static let lightsRef = Reference([Bool].self)
    static let lights = Regex {
        "["
        Capture(as: lightsRef) {
            OneOrMore {
                ChoiceOf {
                    "."
                    "#"
                }
            }
        } transform: { capture in
            capture.reduce(into: [Bool]()) { $0.append($1 == "#" ? true : false) }
        }
        "] "
    }

    static let buttonsRef = Reference([[Int]].self)
    static let buttons = Regex {
        Capture(as: buttonsRef) {
            OneOrMore {
                "("
                OneOrMore {
                    .digit
                    Optionally(",")
                }
                ") "
            }
        } transform: { transformButtons($0) }
    }

    static func transformButtons(_ input: Substring) -> [[Int]] {
        var output = [[Int]]()

        var current = [Int]()
        for character in input {
            switch character {
            case ")":
                output.append(current)
                current = []
            case "(", " ", ",":
                break
            default:
                let number = character.wholeNumberValue!
                current.append(number)
            }
        }

        return output
    }

    static let joltagesRef = Reference([Int].self)
    static let joltages = Regex {
        "{"
        Capture(as: joltagesRef) {
            OneOrMore(.any)
        } transform: { $0.allDigits }
        "}"
    }

    static let regex = Regex {
        lights
        buttons
        joltages
    }

    func run(input: String) -> String {
        input.lines.map { line in
            let match = try! Self.regex.wholeMatch(in: line)!
            let buttons = match[Self.buttonsRef]
            let joltages = match[Self.joltagesRef]
            return calculatePresses(configuration: .init(joltages: joltages, buttons: buttons))
        }
        .sum
        .description
    }

    struct JoltageConfiguration: Hashable {
        let joltages: [Int]
        let buttons: [[Int]]
    }

    var joltageCache: [JoltageConfiguration: Int] = [:]
    func calculatePresses(configuration: JoltageConfiguration) -> Int {
        if let cacheHit = joltageCache[configuration] {
            return cacheHit
        }
        let joltages = configuration.joltages
        let buttons = configuration.buttons
        if joltages.allSatisfy({ $0 == 0 }) {
            joltageCache[configuration] = 0
            return 0
        }
        if joltages.contains(where: { $0 < 0 }) {
            joltageCache[configuration] = 100_000
            return 100_000
        }
        let combinations = allCombinations(configuration: .init(lights: joltages.map(\.isOdd), buttons: buttons))
        var result = 100_000
        for combination in combinations {
            let newJoltages = combination.reduce(into: joltages) { result, buttons in
                for button in buttons {
                    result[button] -= 1
                }
            }
            .map { $0 / 2 }
            let newResult = calculatePresses(configuration: .init(joltages: newJoltages, buttons: buttons))
            result = min(result, (2 * newResult) + combination.count)
        }
        joltageCache[configuration] = result
        return result
    }

    struct LightConfiguration: Hashable {
        let lights: [Bool]
        let buttons: [[Int]]
    }

    var lightCache: [LightConfiguration: [[[Int]]]] = [:]
    func allCombinations(configuration: LightConfiguration) -> [[[Int]]] {
        if let cacheHit = lightCache[configuration] {
            return cacheHit
        }
        let lights = configuration.lights
        let buttons = configuration.buttons
        var result = [[[Int]]]()
        if lights.allSatisfy(!) {
            result.append([])
        }
        for length in 1...buttons.count {
            for combination in buttons.combinations(ofCount: length) {
                let output = combination.reduce(into: lights) { result, buttons in
                    for button in buttons {
                        result[button].toggle()
                    }
                }
                if output.allSatisfy(!) {
                    result.append(combination)
                }
            }
        }

        lightCache[configuration] = result
        return result
    }
}
