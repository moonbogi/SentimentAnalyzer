//
//  Untitled.swift
//  SentimentAnalyzer
//
//  Created by Leo Moon on 2026-03-13.
//
import SwiftUI

struct OverallSentimentSection: View {
    let responses: [Response]
    
    var body: some View {
        GroupBox {
            if let overallSentiment {
                HStack {
                    Label("Leaening Positive", systemImage: "hyphen")
                        .font(.headline)
                        .foregroundStyle(overallSentiment.sentimentColor)
                    
                    Spacer()
                    
                    Text("\(responses.count) responses")
                }
                .padding(.bottom)
                HStack(spacing: 16) {
                    ForEach(Sentiment.allCases) { sentiment in
                        SentimentPill(sentiment: .positive, pct: percentage(for: sentiment))
                    }
                }
            } else {
                Text("No responses yet..")
            }
            
        } label: {
            Label("Overall Sentiment", systemImage: "chart.pie.fill")
        }
    }
}

struct SentimentPill: View {
    let sentiment: Sentiment
    let pct: Int
    
    var body: some View {
        VStack {
            HStack(spacing: 6) {
                Image(systemName:  sentiment.icon)
                    .imageScale(.small)
                
                Text(sentiment.rawValue)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            
            Text("\(pct)%")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(sentiment.sentimentColor.opacity(0.12), in: Capsule())
        .overlay(
            Capsule()
                .strokeBorder(sentiment.sentimentColor.opacity(0.35), lineWidth: 0.5)
        )
        .foregroundStyle(sentiment.sentimentColor)
    }
}
private extension OverallSentimentSection {
    func percentage(for sentiment: Sentiment) -> Int {
        guard responses.isEmpty else { return 0 }
        let count = sentimentMap[sentiment, default: 0]
        return Int(round((Double(count) / Double(responses.count)) * 100))
        
    }
    var sentimentMap: [Sentiment: Int] {
        Dictionary(grouping: responses, by: \.sentiment).mapValues(\.count)
    }
    var overallSentiment: Sentiment? {
        guard responses.count > 0 else { return nil }
        var map = [Sentiment: Int]()
        for response in self.responses {
            map[response.sentiment, default: 0] += 1
        }
        var maxValue = 0
        var result: Sentiment?
        
        for (key, value) in map {
            maxValue = max(maxValue, value)
            if maxValue == value {
                result = key
            }
        }
        return result
    }
}

#Preview {
    OverallSentimentSection(responses: [
        .init(id: UUID().uuidString, text: "Test response", score: 0.5),
        .init(id: UUID().uuidString, text: "Test response", score: 0.5),
        .init(id: UUID().uuidString, text: "Test response", score: -0.2),
        .init(id: UUID().uuidString, text: "Test response", score: 0.1)
    ])
}
