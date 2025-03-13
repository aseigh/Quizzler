//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
//  Updated by Ariana Seigh on 03/12/2025.
//
//  Enhancements:
//  1) 10 sec timer for each question
//  2) Sound for correct and incorrect answers
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    // Connect to QuizBrain model
    var quizBrain = QuizBrain()
    
    // Variables for timer
    var timer: Timer?
    var timeLeft = 10.0
    
    // Variables for audio
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        startTimer()
    }
    
    // Start timer for each question
    func startTimer() {
        timeLeft = 10.0
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // Update timer functon
    @objc func updateTimer() {
        if timeLeft > 0 {
            timeLeft -= 1
            timerLabel.text = "Time: \(Int(timeLeft)) seconds"
        }
        else {
            timer?.invalidate()
            quizBrain.nextQuestion()
            updateUI()
            startTimer()
        }
    }
    
    // Trigger for when True or False button is pressed
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        timer?.invalidate()
        
        let userAnswer = sender.currentTitle!  // True, False
        let userGotItRight = quizBrain.checkAnswer(userAnswer)
        
        // Change color based on if right or wrong answer
        if userGotItRight {
            sender.backgroundColor = UIColor.green
            
            // Audio for correct
            let url = Bundle.main.url(forResource: "correct", withExtension: "mp3")!
            player = try! AVAudioPlayer(contentsOf: url)
            player.play()
        }
        else {
            sender.backgroundColor = UIColor.red
            
            // Audio for incorrect
            let url = Bundle.main.url(forResource: "incorrect", withExtension: "mp3")!
            player = try! AVAudioPlayer(contentsOf: url)
            player.play()
        }
        
        quizBrain.nextQuestion()
        
        // Delay button color for 0.2 secs
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
        startTimer()
    }
    
    // Function that captures functionality (update questionLabel based off current questionNumber) for multiple uses
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        
        // Update progress bar as quiz goes on
        progressBar.progress = quizBrain.getProgress()
        
        // Print user's score
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        
        // Print time left
        timerLabel.text = "Time: \(Int(timeLeft)) seconds"
        
        // Reset answer button's color for next question
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
    }

}

