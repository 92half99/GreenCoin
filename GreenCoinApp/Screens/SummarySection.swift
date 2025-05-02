import SwiftUI

struct SummarySection: View {
  let co2Saved: String
  let improvement: String

  var body: some View {
    VStack(spacing: 8) {
      Text(co2Saved)
        .font(.system(size: 18))
      if !improvement.isEmpty {
        Text(improvement)
          .font(.system(size: 15))
          .foregroundColor(.secondary)
      }
    }
    .padding()
  }
}
