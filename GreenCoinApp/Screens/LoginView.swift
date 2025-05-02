import SwiftUI

struct LoginView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("showHomePage") var showHomePage = false
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("🌱 GreenCoin")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.greenCoinPrimary)

            Text("Log in to track impact and earn 🌍")
                .multilineTextAlignment(.center)
                .font(.bodyRounded)
                .padding(.horizontal)

            TextField("👤 Username", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            SecureField("🔒 Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            Button(action: {
                isLoggedIn = true
                showHomePage = false
            }) {
                Text("🚀 Log In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.greenCoinPrimary)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .background(Color.greenCoinBackground.ignoresSafeArea())
    }
}
