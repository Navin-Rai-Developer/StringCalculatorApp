//
//  ViewController.swift
//  StringCalculatorApp
//
//  Created by Navin Rai on 30/06/25.
//

import UIKit

class ViewController: UIViewController {
    let emojiLabel = UILabel()
    let inputField = UITextField()
    let resultLabel = UILabel()
    let calculateButton = UIButton(type: .system)
    let copyButton = UIButton(type: .system)
    let clearButton = UIButton(type: .system)
    let calculator = Calculator()

    override func viewDidLoad() {
        super.viewDidLoad()
        applyGradientBackground()
        setupUI()
    }

    private func setupUI() {
        // Emoji / Icon
        emojiLabel.text = "🧮"
        emojiLabel.font = .systemFont(ofSize: 60)
        emojiLabel.textAlignment = .center

        // Input
        inputField.placeholder = "Enter string input"
        inputField.borderStyle = .roundedRect
        inputField.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        inputField.layer.cornerRadius = 8
        inputField.clipsToBounds = true

        // Calculate Button
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        calculateButton.tintColor = .white
        calculateButton.backgroundColor = .systemBlue
        calculateButton.layer.cornerRadius = 10
        calculateButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        calculateButton.addTarget(self, action: #selector(calculateTapped), for: .touchUpInside)

        // Result Label
        resultLabel.textAlignment = .center
        resultLabel.font = .boldSystemFont(ofSize: 24)
        resultLabel.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        resultLabel.layer.cornerRadius = 8
        resultLabel.clipsToBounds = true
        resultLabel.numberOfLines = 0

        // Copy Button
        copyButton.setTitle("Copy Result", for: .normal)
        copyButton.setTitleColor(.systemGreen, for: .normal)
        copyButton.addTarget(self, action: #selector(copyResult), for: .touchUpInside)

        // Clear Button
        clearButton.setTitle("Clear", for: .normal)
        clearButton.setTitleColor(.systemRed, for: .normal)
        clearButton.addTarget(self, action: #selector(clearInput), for: .touchUpInside)

        let buttonStack = UIStackView(arrangedSubviews: [copyButton, clearButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 20
        buttonStack.distribution = .fillEqually

        let mainStack = UIStackView(arrangedSubviews: [emojiLabel, inputField, calculateButton, resultLabel, buttonStack])
        mainStack.axis = .vertical
        mainStack.spacing = 20
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func applyGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor.systemIndigo.cgColor,
            UIColor.systemTeal.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }

    @objc private func calculateTapped() {
        guard let input = inputField.text else { return }
        do {
            let result = try calculator.add(input)
            resultLabel.textColor = .label
            UIView.animate(withDuration: 0.3, animations: {
                self.resultLabel.alpha = 0
            }) { _ in
                self.resultLabel.text = "Result: \(result)"
                UIView.animate(withDuration: 0.3) {
                    self.resultLabel.alpha = 1
                }
            }
        } catch {
            resultLabel.textColor = .red
            resultLabel.text = (error as NSError).domain
        }
    }

    @objc private func copyResult() {
        UIPasteboard.general.string = resultLabel.text
    }

    @objc private func clearInput() {
        inputField.text = ""
        resultLabel.text = ""
    }
}
