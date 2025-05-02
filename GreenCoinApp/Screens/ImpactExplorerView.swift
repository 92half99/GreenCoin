//
//  ImpactExplorerView.swift
//  GreenCoinApp
//
//  Created by DAUG on 2/5/2025.
//


import SwiftUI

struct ImpactExplorerView: View {
    let facts = [
        "🌊 Recycling one plastic bottle saves enough energy to power a light bulb for 3 hours.",
        "🌱 Trees absorb CO₂ and help cool the planet.",
        "🚿 A 5-minute shower uses about 50 litres of water.",
        "🚯 Littering harms local wildlife and ecosystems.",
        "🔋 Recharging batteries saves toxic waste."
    ]

    var body: some View {
        NavigationView {
            List(facts, id: \.self) { fact in
                Text(fact)
                    .padding(.vertical, 8)
                    .font(.bodyRounded)
            }
            .navigationTitle("🌍 Explore Impact")
            .background(Color.greenCoinBackground)
            .withProfileButton()
        }
    }
}
