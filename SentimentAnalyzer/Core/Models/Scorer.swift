//
//  Scorer.swift
//  SentimentAnalyzer
//
//  Created by Leo Moon on 2026-03-13.
//

import Foundation
import NaturalLanguage

struct Scorer {
    let tagger = NLTagger(tagSchemes: [ .sentimentScore])
    
    func score(_ text: String) -> Double {
        var sentimentScore: Double = 0
        tagger.string = text
        
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .paragraph, scheme: .sentimentScore) { tag, _ in
            if let sentimentString = tag?.rawValue, let score = Double(sentimentString) {
                sentimentScore = score
            }
            return false
        }
        return sentimentScore
    }
}
