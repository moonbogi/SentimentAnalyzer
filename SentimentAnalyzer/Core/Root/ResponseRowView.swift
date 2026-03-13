//
//  ResponseRowView.swift
//  SentimentAnalyzer
//
//  Created by Leo Moon on 2026-03-13.
//

import SwiftUI

struct ResponseRowView: View {
    let response: Response
    
    var body: some View {
        HStack {
            Text(response.text)
            
            Spacer()
            
            Image(systemName: response.sentiment.icon)
                .frame(width: 30, height: 30)
                .foregroundStyle(.white)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(response.sentiment.sentimentColor)
                }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ResponseRowView(
        response: Response(
            id: UUID().uuidString,
            text: Response.sampleResponses[0],
            score: 1.0
        )
    )
}
