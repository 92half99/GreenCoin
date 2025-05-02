//
//  ChatBotView.swift
//  GreenCoinApp
//
//  Created by DAUG on 2/5/2025.
//


import SwiftUI

struct ChatBotView: View {
    @State private var selectedQuestion = ""

    let questions = [
        "How can I earn points?",
        "What are some sustainable habits?",
        "Where can I find rewards?"
    ]

    func answer(for question: String) -> String {
        switch question {
        case "How can I earn points?": return "✅ You earn points by logging sustainable actions like biking or recycling."
        case "What are some sustainable habits?": return "🌱 Try composting, biking, reducing plastic, and eating local."
        case "Where can I find rewards?": return "🎁 Rewards are in the Rewards tab. Tap to redeem once you have enough points."
        default: return "Ask a question to get started."
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                ForEach(questions, id: \.self) { question in
                    Button(action: {
                        selectedQuestion = question
                    }) {
                        Text(question)
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.greenCoinPrimary.opacity(0.1))
                            .cornerRadius(10)
                    }
                }

                if !selectedQuestion.isEmpty {
                    Text(answer(for: selectedQuestion))
                        .padding()
                        .background(Color.greenCoinPrimary.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.top)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Ask GreenBot 🤖")
        }
    }
}
