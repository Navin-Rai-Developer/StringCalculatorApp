# StringCalculatorApp
iOS TDD Kata – String Calculator with custom delimiter support
# 🧮 StringCalculatorApp

A simple, test-driven iOS app (UIKit + Swift) that implements the classic **String Calculator Kata** using **TDD best practices**, **custom delimiters**, and a polished user interface.

---

## 📱 App Features

- ✅ Add comma-separated or newline-separated numbers
- ✅ Support for custom delimiters (e.g., `//;\n1;2`)
- ✅ Support for multi-character delimiters (e.g., `//[***]\n1***2`)
- ✅ Throws errors for:
  - Invalid values like `"abc"`
  - Negative numbers (with full list)
- ✅ Beautiful UIKit-based UI with:
  - Gradient background
  - Result animation
  - Emoji header
  - Copy result / clear input buttons

---

## 🧪 TDD & Test Coverage

All logic is fully covered with unit tests under `StringCalculatorAppTests/CalculatorTests.swift`.

TDD Steps followed:
- ❌ Write failing test
- ✅ Make it pass
- ♻️ Refactor
- ✅ Commit per test/feature with clear messages

---

## 🧠 Architecture

- `Calculator.swift` → Core logic (testable, pure Swift)
- `ViewController.swift` → UI controller with UIKit components
- MV pattern with clear separation of logic and UI
- Uses `NSError` for custom validation errors

---

## 🚀 How to Run

1. Clone this repo  
   `git clone https://github.com/Navin-Rai-Developer/StringCalculatorApp.git`

2. Open in Xcode (15+)

3. Build & Run (iPhone 14+ simulator)

---

## 🛠️ Technologies Used

- Swift 5
- UIKit
- XCTest (unit tests)
- Git + GitHub
