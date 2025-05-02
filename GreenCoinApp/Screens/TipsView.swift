import SwiftUI

struct TipsView: View {
    let tips = [
        "💧 Take shorter showers to save water.",
        "🛍️ Bring your own bag to avoid plastic.",
        "🔌 Unplug devices when not in use.",
        "🍎 Compost food scraps.",
        "🚲 Use public transport or bike."
    ]

    var body: some View {
        NavigationView {
            List(tips, id: \.self) { tip in
                Text(tip)
                    .padding(.vertical, 8)
                    .font(.bodyRounded)
            }
            .navigationTitle("🌿 Quick Tips")
            .background(Color.greenCoinBackground)
            .withProfileButton()
        }
    }
}
