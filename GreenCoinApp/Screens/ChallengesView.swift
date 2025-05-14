import SwiftUI
import Foundation

struct ChallengesView: View {
    @EnvironmentObject private var statsManager: UserStatsManager
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(title: "Challenges")
            ScrollView {
                VStack(spacing: 24) {
                    ActiveChallengesSection()
                    WeeklyChallengesSection()
                    WeeklyGoalsSection()
                }
                .padding(.vertical)
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}


private struct ActiveChallengesSection: View {
    private struct Constants {
        static let strokeWeight1: CGFloat = 1
        static let colorGreen75 = Color(red: 0.62, green: 0.88, blue: 0.67)
        static let colorGreen5  = Color(red: 0,    green: 0.10, blue: 0.02)
        static let fontSize18: CGFloat      = 18
        static let fontFamilyFont1          = "Montserrat"
        static let fontWeight700: Font.Weight = .bold
        static let fontFamilyFont2          = "Inter"
        static let fontSize1525: CGFloat    = 15.25
        static let fontWeight400: Font.Weight = .regular
        static let colorGrey46  = Color(red: 0.46, green: 0.46, blue: 0.46)
        static let colorSpringGreen36 = Color(red: 0.62, green: 0.88, blue: 0.67).opacity(0.36)
        static let colorSpringGreen51 = Color(red: 0.62, green: 0.88, blue: 0.67).opacity(0.51)
        static let lineHeight16: CGFloat   = 16
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .frame(height: 316)
                .shadow(color: .black.opacity(0.05), radius: 1, x: 0, y: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Constants.colorGreen75, lineWidth: Constants.strokeWeight1)
                )
                .frame(maxWidth: .infinity)
                .padding(.horizontal)

            VStack(spacing: 16) {
                Text("Active Challenges")
                    .font(
                        Font.custom(Constants.fontFamilyFont1, size: Constants.fontSize18)
                            .weight(Constants.fontWeight700)
                    )
                    .foregroundColor(Constants.colorGreen5)
                    .frame(width: 169.78, height: 28, alignment: .leading)

                Image("SVG")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .opacity(0.2)

                Text("No active challenges. Join a challenge to\nearn more points!")
                    .font(
                        Font.custom(Constants.fontFamilyFont2, size: Constants.fontSize1525)
                            .weight(Constants.fontWeight400)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Constants.colorGrey46)
                    .frame(width: 294.68, height: 48)

                HStack(alignment: .center, spacing: Constants.lineHeight16) {
                    Text("Browse Challenges")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Constants.colorGreen5)
                }
                .padding(.vertical, 10.5)
                .padding(.horizontal, 72.88)
                .frame(width: 303, height: 40)
                .background(Constants.colorSpringGreen36)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: 0.5)
                        .stroke(Constants.colorSpringGreen51, lineWidth: Constants.strokeWeight1)
                )
            }
        }
    }
}


private struct WeeklyChallengesSection: View {
    var body: some View {
        VStack(spacing: 16) {
            ChallengeCard(
                title: "Bike to Work Week",
                subtitle: "Use bicycle instead of car for 5 days",
                daysLeft: "3 days left",
                progress: 0.6,
                background: Color(red: 0.9, green: 1, blue: 0.91)
            )
            ChallengeCard(
                title: "Recycle Marathon",
                subtitle: "Recycle 5 kg of waste materials",
                daysLeft: "4 days left",
                progress: 0.4,
                background: Color(red: 0.9, green: 1, blue: 0.91)
            )
        }
    }
}

private struct ChallengeCard: View {
    let title: String
    let subtitle: String
    let daysLeft: String
    let progress: Double
    let background: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(background)
                .frame(height: 112)
                .shadow(color: Color(red: 0.98, green: 0.98, blue: 0.98).opacity(0.25),
                        radius: 4, x: 0, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .inset(by: 0.5)
                        .stroke(background, lineWidth: 1)
                )
                .frame(maxWidth: .infinity)
                .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(Font.custom("Inter", size: 16).weight(.bold))
                    .foregroundColor(Color(red: 0, green: 0.23, blue: 0.3))
                    .frame(width: 146, alignment: .leading)

                Text(daysLeft)
                    .font(Font.custom("Inter", size: 10).weight(.semibold))
                    .foregroundColor(Color(red: 0.43, green: 0.49, blue: 0.74))
                    .frame(width: 72, alignment: .leading)

                Text(subtitle)
                    .font(Font.custom("Inter", size: 13).weight(.medium))
                    .foregroundColor(Color(red: 0, green: 0.3, blue: 0.4).opacity(0.6))
                    .frame(width: 226, alignment: .leading)

                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .frame(width: 295, height: 8)
                        .cornerRadius(3)
                    Rectangle()
                        .fill(Color(red: 0, green: 0.3, blue: 0.4).opacity(0.6))
                        .frame(width: CGFloat(progress) * 295, height: 8)
                        .cornerRadius(3)
                }

                HStack {
                    Text(String(format: "%.0f/%.0f days", progress * 5, 5))
                        .font(Font.custom("Inter", size: 11).weight(.medium))
                        .foregroundColor(Color(red: 0, green: 0.3, blue: 0.4).opacity(0.6))
                    Spacer()
                    Text(String(format: "%.0f%%", progress * 100))
                        .font(Font.custom("Inter", size: 11).weight(.medium))
                        .foregroundColor(Color(red: 0, green: 0.3, blue: 0.4).opacity(0.6))
                }
                .frame(width: 295)
            }
            .padding()
        }
    }
}


private struct WeeklyGoalsSection: View {
    private struct Constants {
        static let strokeWeight1: CGFloat = 1
        static let colorSpringGreen51 = Color(red: 0.62, green: 0.88, blue: 0.67).opacity(0.51)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.95, green: 0.99, blue: 0.96))
                .frame(height: 236)
                .shadow(color: .black.opacity(0.05), radius: 1, x: 0, y: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Constants.colorSpringGreen51, lineWidth: Constants.strokeWeight1)
                )
                .frame(maxWidth: .infinity)
                .padding(.horizontal)

            Image("SVG")
                .resizable()
                .frame(width: 120, height: 120)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                .rotationEffect(Angle(degrees: -90))
        }
    }
}
