import SwiftUI


struct RewardItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let subtitle: String
    let cost: Int
}


struct MarketplaceView: View {
    @EnvironmentObject private var statsManager: UserStatsManager
    
    private let categories = ["All", "Products", "Discounts", "Services", "Donations"]
    @State private var selectedCategory = "All"
    
    private let rewards: [RewardItem] = [
        .init(imageName: "waterBottle", title: "Eco-Friendly Water Bottle",
              subtitle: "100% recycled materials, BPA free", cost: 200),
        .init(imageName: "sneakers", title: "Sustainable Sneakers",
              subtitle: "Made from ocean plastics, 15% discount", cost: 500),
        .init(imageName: "coffeeCup", title: "Reusable Coffee Cup",
              subtitle: "Help reduce single-use waste", cost: 150),
        .init(imageName: "solarBank", title: "Solar Power Bank",
              subtitle: "Charge your devices with solar energy", cost: 400)
    ]
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(title: "Rewards Marketplace")
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    Text("Rewards Marketplace")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                        .padding(.horizontal)
                    
                    HStack {
                        Text("\(statsManager.dailyPoints) SP Available")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Color(red: 0.38, green: 0.52, blue: 0.45))
                        Spacer()
                    }
                    .padding(.horizontal)
                    .frame(height: 30)
                    .background(Color(red: 0.91, green: 0.93, blue: 0.92))
                    .cornerRadius(16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(categories, id: \.self) { cat in
                                Text(cat)
                                    .font(.custom("Nunito", size: 13))
                                    .fontWeight(selectedCategory == cat ? .bold : .regular)
                                    .foregroundColor(selectedCategory == cat
                                        ? .white
                                        : Color(red: 0.07, green: 0.07, blue: 0.07))
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .background(selectedCategory == cat
                                        ? Color(red: 0.0, green: 0.5, blue: 0.0)
                                        : Color.clear)
                                    .cornerRadius(12)
                                    .onTapGesture { selectedCategory = cat }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Text("Available Rewards")
                        .font(.custom("Nunito", size: 18).weight(.heavy))
                        .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(rewards) { item in
                            VStack(alignment: .leading, spacing: 8) {
                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .cornerRadius(8)
                                
                                Text(item.title)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Text(item.subtitle)
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                                    .lineLimit(2)
                                
                                Text("By Puma")
                                    .font(.system(size: 11))
                                    .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                                
                                HStack {
                                    Text("\(item.cost) SP")
                                        .font(.system(size: 13, weight: .bold))
                                        .foregroundColor(Color(red: 0.38, green: 0.52, blue: 0.45))
                                    
                                    Spacer()
                                    
                                    Button {
                                        statsManager.redeem(points: item.cost)
                                    } label: {
                                        Text(statsManager.dailyPoints >= item.cost ? "Redeem" : "Not Enough Points")
                                            .font(.system(size: 13, weight: .bold))
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 6)
                                            .background(statsManager.dailyPoints >= item.cost
                                                ? Color.green
                                                : Color.gray.opacity(0.3))
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                    .disabled(statsManager.dailyPoints < item.cost)
                                    .frame(width: 100)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .inset(by: 0.5)
                                    .stroke(Color.black.opacity(0.3), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Spacer()
                        Text("View All")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.0, green: 0.5, blue: 0.0))
                        Spacer()
                    }
                    .padding(.vertical, 8)
                }
                .padding(.vertical)
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.99))
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
