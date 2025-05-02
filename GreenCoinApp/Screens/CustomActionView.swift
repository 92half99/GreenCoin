import SwiftUI

struct CustomActionView: View {
  @EnvironmentObject var pointsManager: PointsManager
  @Environment(\.dismiss) private var dismiss

  @State private var title = ""
  @State private var points = ""

  var body: some View {
    NavigationView {
      Form {
        Section("Action") {
          TextField("Description", text: $title)
        }
        Section("Points") {
          TextField("Points", text: $points)
            .keyboardType(.numberPad)
        }
      }
      .navigationTitle("New Action")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("Cancel") { dismiss() }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Add") {
            guard let pts = Int(points), !title.isEmpty else { return }
            pointsManager.addCustomAction(title: title, points: pts)
            dismiss()
          }
          .disabled(title.isEmpty || Int(points) == nil)
        }
      }
    }
  }
}
