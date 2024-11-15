//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Peek A Boo on 2024-11-14.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate
{
    
    @IBOutlet var ComputerLabel: UILabel!
    @IBOutlet var PickerView: UIPickerView!
    @IBOutlet var SelectedLabel: UILabel!
    let option = ["Rock","Paper","Scissors"]
    var countdownTimer: Timer?
    @objc var countdown = 3
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SelectedLabel.text = "You chosed: Rock"
        resultLabel.adjustsFontSizeToFitWidth = true
            resultLabel.minimumScaleFactor = 0.5 // Scale down to 50% if needed
            resultLabel.numberOfLines = 1
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return option[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return option.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SelectedLabel.text = "You chosed: \(option[row])"
    }
    
    @IBAction func StartButtonPressed(_ sender: UIButton) {
//        if SelectedLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
//                // Set a default choice
//                SelectedLabel.text = "You chosed: rock"
//            }
        startCountdown()
        
        
    }
    
    func startCountdown() {
        countdown = 3 // Reset countdown
        countdownTimer?.invalidate() // Stop any previous timer
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountdown() {
        if countdown > 0 {
            // Show countdown in ComputerLabel
            ComputerLabel.text = "\(countdown)"
            countdown -= 1
        } else {
            // When countdown reaches 0, show a random option
            countdownTimer?.invalidate()
            ComputerLabel.text = "Computer chosed: \(option.randomElement() ?? "Rock")"
            winLogic()
        }
    }
    func winLogic() {
        // Clean player choice text by removing the "You chosed: " prefix
        guard let playerChoice = SelectedLabel.text?
            .replacingOccurrences(of: "You chosed: ", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased(),
              let computerChoice = ComputerLabel.text?
            .replacingOccurrences(of: "Computer chosed: ", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased() else {
                resultLabel.text = "Error: Missing choices"
                return
        }
        
        // Check if it's a tie first
        if playerChoice == computerChoice {
            resultLabel.text = "It's a tie"
        } else if playerChoice == "rock" && computerChoice == "scissors" {
            resultLabel.text = "You Won"
        } else if playerChoice == "scissors" && computerChoice == "paper" {
            resultLabel.text = "You Won"
        } else if playerChoice == "paper" && computerChoice == "rock" {
            resultLabel.text = "You Won"
        } else if computerChoice == "scissors" && playerChoice == "paper" {
            resultLabel.text = "You Lose"
        } else if computerChoice == "rock" && playerChoice == "scissors" {
            resultLabel.text = "You Lose"
        } else if computerChoice == "paper" && playerChoice == "rock" {
            resultLabel.text = "You Lose"
        }
        
        print("Choices Your: \(playerChoice), Computer choice: \(computerChoice), Result: \(resultLabel.text ?? "No result")")
        startButton.setTitle("Play Again", for: .normal)
    }

}
