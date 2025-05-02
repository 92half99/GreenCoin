import SwiftUI

struct ProgressRingView: View {
  let progress: Double  // 0.0–1.0

  var body: some View {
    ZStack {
      Circle()
        .stroke(Color.gray.opacity(0.3), lineWidth: 12)

      Circle()
        .trim(from: 0, to: min(progress, 1))
        .stroke(
          Color.green,
          style: StrokeStyle(lineWidth: 12, lineCap: .round)
        )
        .rotationEffect(.degrees(-90))
        .animation(.easeInOut, value: progress)

      Text("\(Int(progress * 100))%")
        .font(.system(size: 20, weight: .semibold))
        .foregroundColor(.black)
    }
  }
}
