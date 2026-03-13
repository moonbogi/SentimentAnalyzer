//
//  Sentiment.swift
//  SentimentAnalyzer
//
//  Created by Leo Moon on 2026-03-13.
//

import SwiftUI
import Charts


enum Sentiment: String, Plottable {
    case positive = "Positive"
    case moderate = "Moderate"
    case negative = "Negative"
    
    init(_ score: Double) {
        if score > 0.2 {
            self = .positive
        } else if score < -0.2 {
            self = .negative
        } else {
            self = .moderate
        }
    }
    
    var icon: String {
        switch self {
        case .positive:
            return "chevron.up.2"
        case .negative:
            return "chevron.down.2"
        case .moderate:
            return "minus"
        }
    }
    
    var sentimentColor: Color {
        switch self {
        case .positive:
            return .teal
        case .negative:
            return .red
        case .moderate:
            return .gray
        }
    }
}
