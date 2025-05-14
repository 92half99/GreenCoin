import SwiftUI


struct TopBarView: View {
    let title: String
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Image(systemName: "leaf.fill")
                    .font(.system(size: 20))
                    .foregroundColor(Color.accentColor)
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.accentColor)
            }

            Spacer()

            HStack(spacing: 16) {
                NavigationLink {
                    ProfileView()
                } label: {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 24))
                }
                Image(systemName: "line.horizontal.3")
                    .font(.system(size: 24))
            }
            .foregroundColor(.black)
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.white.ignoresSafeArea(edges: .top))
    }
}
