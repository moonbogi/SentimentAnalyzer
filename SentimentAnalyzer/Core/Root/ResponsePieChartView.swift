//
//  ResponsePieChartView.swift
//  SentimentAnalyzer
//
//  Created by Leo Moon on 2026-03-13.
//

import Charts
import SwiftUI

struct ResponsePieChartView: View {
    let responses: [Response]
    
    init(responses: [Response]) {
        self.responses = responses.sorted { $0.score < $1.score }
    }
    
    var body: some View {
        Chart(responses) { response in
            SectorMark(
                angle: .value("Type", response.score),
                innerRadius: .ratio(0.75)
            )
            .foregroundStyle(by: .value("sentiment", response.sentiment))
        }
        .chartLegend(position: .trailing, alignment: .center)
        .frame(height: 200)
        .padding()
        .chartForegroundStyleScale([
            Sentiment.positive: Sentiment.positive.sentimentColor,
            Sentiment.negative: Sentiment.negative.sentimentColor,
            Sentiment.moderate: Sentiment.moderate.sentimentColor
        ])
        .chartBackground { proxy in
            GeometryReader { geometry in
                if let anchor = proxy.plotFrame {
                    let frame = geometry[anchor]
                    Image(systemName: "location")
                        .resizable()
                        .scaledToFit()
                        .frame(height: frame.height * 0.4)
                        .position(x: frame.midX, y: frame.midY)
                }
            }
        }
    }
}

#Preview {
    ResponsePieChartView(responses: [])
}
