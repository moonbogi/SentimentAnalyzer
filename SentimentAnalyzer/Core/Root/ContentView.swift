//
//  ContentView.swift
//  SentimentAnalyzer
//
//  Created by Leo Moon on 2026-03-13.
//

import SwiftUI

struct ContentView: View {
    @State private var responseText = ""
    @State private var responses = [Response]()
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    Text("Chart")
                    
                    Text("Overview Section")
                    
                    ForEach(responses) { response in
                        ResponseRowView(response: response)
                            .padding(.horizontal)
                    }
                }
                HStack {
                    TextField(
                        "Your thoughts on the future of AI...",
                        text: $responseText,
                        axis: .vertical
                    )
                    .padding(12)
                    .padding(.leading, 4)
                    .padding(.leading, 4)
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(.systemGray4), lineWidth: 1.0)
                    }
                    
                    Button("Done") {
                        onDoneTapped()
                    }
                    .fontWeight(.semibold)
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .background(Color(.systemGroupedBackground))
        }
        .task {
            for response in Response.sampleResponses {
                saveResponse(response)
            }
        }
    }
}

private extension ContentView {
    func saveResponse(_ text: String, shouldInsert: Bool = false) {
        let scorer = Scorer()
        let score = scorer.score(text)
        let response = Response(id: UUID().uuidString, text: text, score: score)
        responses.insert(response, at: 0)
        
        if shouldInsert {
            responses.insert(response, at: 0)
        } else {
            responses.append(response)
        }
    }
    
    func onDoneTapped() {
        guard !responseText.isEmpty else { return }
        saveResponse(responseText, shouldInsert: true)
        responseText = ""
    }
}

#Preview {
    ContentView()
}
