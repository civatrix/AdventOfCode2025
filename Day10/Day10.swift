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
            let lights = match[Self.lightsRef]
            let buttons = match[Self.buttonsRef]
            return calculatePresses(lights: lights, buttons: buttons)
        }
        .sum
        .description
    }
    
    func calculatePresses(lights: [Bool], buttons: [[Int]]) -> Int {
        for length in 1 ... buttons.count {
            for permuatation in buttons.permutations(ofCount: length) {
                let output = permuatation.reduce(into: [Bool](repeating: false, count: lights.count)) { result, buttons in
                    for button in buttons {
                        result[button].toggle()
                    }
                }
                if output == lights {
                    return length
                }
            }
        }
        
        fatalError("Unable to find a solution")
    }
}
