//
//  Calculator.swift
//  StringCalculatorApp
//
//  Created by Navin Rai on 30/06/25.
//

import Foundation

import Foundation

struct Calculator {
    func add(_ numbers: String) throws -> Int {
        if numbers.isEmpty { return 0 }

        // Normalize \n typed from UITextField
        let normalizedInput = numbers.replacingOccurrences(of: "\\n", with: "\n")

        var delimiters = [",", "\n"]
        var input = normalizedInput

        // Custom delimiter logic
        if normalizedInput.hasPrefix("//") {
            let parts = normalizedInput.components(separatedBy: "\n")
            guard parts.count >= 2 else {
                throw NSError(domain: "Invalid format: missing newline after custom delimiter", code: -3)
            }

            let delimiterLine = parts[0].dropFirst(2)

            // Handle multi-character delimiters: //[***]
            if delimiterLine.hasPrefix("[") && delimiterLine.hasSuffix("]") {
                let custom = delimiterLine
                    .trimmingCharacters(in: CharacterSet(charactersIn: "[]"))
                delimiters = [custom]
            } else {
                delimiters = [String(delimiterLine)]
            }

            input = parts.dropFirst().joined(separator: "\n")
        }

        // Tokenize based on delimiter
        var split = [input]
        for delim in delimiters {
            split = split.flatMap { $0.components(separatedBy: delim) }
        }

        var numbersArray = [Int]()
        var invalids = [String]()

        for token in split {
            let trimmed = token.trimmingCharacters(in: .whitespaces)
            if trimmed.isEmpty { continue }

            if let num = Int(trimmed) {
                numbersArray.append(num)
            } else {
                invalids.append(trimmed)
            }
        }

        if !invalids.isEmpty {
            throw NSError(domain: "Invalid number found: '\(invalids.joined(separator: ", "))'", code: -2)
        }

        let negatives = numbersArray.filter { $0 < 0 }
        if !negatives.isEmpty {
            throw NSError(domain: "Negative numbers not allowed: \(negatives.map(String.init).joined(separator: ", "))", code: -1)
        }

        return numbersArray.reduce(0, +)
    }
}
