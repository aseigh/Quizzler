//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by Ariana Seigh on 3/12/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
//

import Foundation

struct QuizBrain {
    
    // Property
    let quiz = [
        Question(q: "A slug's blood is green.", a: "True"),
        Question(q: "Approximately one quarter of human bones are in the feet.", a: "True"),
        Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: "True"),
        Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: "True"),
        Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: "False"),
        Question(q: "It is illegal to pee in the Ocean in Portugal.", a: "True"),
        Question(q: "You can lead a cow down stairs but not up stairs.", a: "False"),
        Question(q: "Google was originally called 'Backrub'.", a: "True"),
        Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: "True"),
        Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: "False"),
        Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: "False"),
        Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", a: "True")
    ]
    
    // Variable to keep track of current question and score
    var questionNumber = 0
    var score = 0
    
    // Functional method for checking user's answer
    mutating func checkAnswer(_ userAnswer: String) -> Bool{
        if userAnswer == quiz[questionNumber].answer {
            // User got it right: increase score and change button color's
            score += 1
            return true
        }
        else {
            // User got it wrong
            return false
        }
    }
    
    // Functional method for returning user's score
    func getScore() -> Int {
        return score
    }
    
    
    // Functional method for text property of questions
    func getQuestionText() -> String{
        return quiz[questionNumber].text
    }
    
    // Functional method for getting progress of quiz
    func getProgress() -> Float {
        let progress = Float(questionNumber + 1) / Float(quiz.count)
        return progress
    }
    
    // Functional method for question progression functionality
    mutating func nextQuestion() {
        
        // Safety to prevent running error
        if questionNumber + 1 < quiz.count {
            questionNumber += 1
        }
        else {
            questionNumber = 0
            score = 0
        }
    }
}
