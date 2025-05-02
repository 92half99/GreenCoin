import SwiftUI

struct HeaderView: View {
  let title: String

  var body: some View {
    Text(title)
      .font(.system(size: 32, weight: .semibold))
      .foregroundColor(Color(red: 0.81, green: 0.82, blue: 0.53))
      .padding(.vertical, 8)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(Color(red: 0.36, green: 0.55, blue: 0.35))
  }
}
