//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Ariana Seigh on 3/12/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    
    // Fields/properties associated with each questions
    let text: String
    let answer: String
    
    init(q: String, a: String) {
        text = q
        answer = a
    }
    
    
}
