import SwiftUI

struct FloatingChatButton: View {
    @State private var showChat = false

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: { showChat = true }) {
                        Image(systemName: "message.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.greenCoinPrimary)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .padding()
                    .sheet(isPresented: $showChat) {
                        ChatBotView()
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

