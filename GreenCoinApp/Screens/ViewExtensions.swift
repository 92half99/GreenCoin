import SwiftUI

extension View {
    func withProfileButton() -> some View {
        self.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.greenCoinPrimary)
                }
            }
        }
    }
}
