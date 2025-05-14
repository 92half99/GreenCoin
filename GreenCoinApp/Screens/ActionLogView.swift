import SwiftUI
import PhotosUI
import UIKit

struct ActionLogView: View {

    struct LoggedAction: Identifiable {
        let id = UUID()
        let title: String
        let subtitle: String
        let points: Int
    }


    private let categories = ["Transport", "Waste", "Energy", "Water", "Other"]
    @State private var selectedCategory = "Transport"
    @State private var descriptionText = ""
    @State private var loggedActions: [LoggedAction] = []
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var pointsText: String = ""
    @EnvironmentObject private var statsManager: UserStatsManager

    private enum Field {
        case description, points
    }
    @FocusState private var focusedField: Field?


    var body: some View {
        VStack(spacing: 0) {
            TopBarView(title: "Log Action")

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    Text("Log Action")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(red: 0, green: 0.10, blue: 0.02))
                        .padding(.horizontal)

                    Text("Record Your Eco-Friendly Actions")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(red: 0, green: 0.10, blue: 0.02))
                        .padding(.horizontal)

                    Text("Select an action category, provide details about what you did, and earn Sustainability Points (SP) for your efforts!")
                        .font(.system(size: 15.25))
                        .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(categories, id: \.self) { cat in
                                Text(cat)
                                    .font(.system(size: 14, weight: .medium))
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .background(
                                        selectedCategory == cat
                                            ? Color(red: 0.62, green: 0.88, blue: 0.67).opacity(0.51)
                                            : Color.clear
                                    )
                                    .cornerRadius(8)
                                    .onTapGesture { selectedCategory = cat }
                            }
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 12) {
                            icon(for: selectedCategory)
                                .font(.system(size: 24))
                                .foregroundColor(.green)
                                .frame(width: 32, height: 32)
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(8)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(selectedCategory)
                                    .font(.system(size: 16, weight: .bold))
                                Text(subtitle(for: selectedCategory))
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                            }
                        }

                        Text("Tell us about your action")
                            .font(.subheadline)

                        TextEditor(text: $descriptionText)
                            .frame(height: 80)
                            .padding(8)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(8)
                            .focused($focusedField, equals: .description)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("Done") {
                                        focusedField = nil
                                    }
                                }
                            }

                        Text("Add a photo")
                            .font(.subheadline)

                        VStack(alignment: .leading, spacing: 8) {
                            PhotosPicker(
                                selection: $selectedItem,
                                matching: .images,
                                photoLibrary: .shared()
                            ) {
                                Text("Choose photo")
                                    .font(.system(size: 14, weight: .medium))
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(Color.green.opacity(0.1))
                                    .cornerRadius(8)
                            }
                            .onChange(of: selectedItem) { _, newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        selectedImageData = data
                                    }
                                }
                            }

                            if let data = selectedImageData, let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .cornerRadius(8)
                            } else {
                                Text("No photo selected")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                        }
                        
                        HStack {
                            Text("Points:")
                            Spacer()
                            TextField("0", text: $pointsText)
                                .keyboardType(.numberPad)
                                .submitLabel(.done)
                                .focused($focusedField, equals: .points)
                                .onSubmit {
                                    focusedField = nil
                                }
                                .multilineTextAlignment(.trailing)
                                .frame(width: 60)
                                .padding(6)
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(6)
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                    .padding(.horizontal)
                    
                    Button("Log Action") {
                        focusedField = nil
                        let pointsValue = Int(pointsText) ?? 0
                        let newAction = LoggedAction(
                            title: selectedCategory,
                            subtitle: descriptionText,
                            points: pointsValue
                        )
                        loggedActions.append(newAction)
                        statsManager.logAction(points: pointsValue)
                        // Reset inputs
                        descriptionText = ""
                        pointsText = ""
                        selectedImageData = nil
                    }
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(8)
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(loggedActions) { action in
                            HStack {
                                icon(for: action.title)
                                    .font(.system(size: 24))
                                    .foregroundColor(.green)
                                    .frame(width: 32, height: 32)
                                    .background(Color.green.opacity(0.1))
                                    .cornerRadius(8)
                                VStack(alignment: .leading) {
                                    Text(action.title)
                                        .font(.headline)
                                    Text(action.subtitle)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text("+\(action.points) SP")
                                    .foregroundColor(.green)
                                    .font(.subheadline)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                        }
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Verification Process")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.yellow)

                        Text("""
                            Must add a photo makes verification possible. Our system may review some activities to ensure accuracy, particularly for high-value actions. Points are typically awarded immediately but may be adjusted if issues are found.
                            """)
                            .font(.system(size: 13.5))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.99))
        }
        .ignoresSafeArea(edges: .bottom)
    }


    private func icon(for category: String) -> some View {
        switch category {
        case "Transport": return Image(systemName: "bicycle")
        case "Waste":     return Image(systemName: "trash")
        case "Energy":    return Image(systemName: "bolt.fill")
        case "Water":     return Image(systemName: "drop.fill")
        default:          return Image(systemName: "square.grid.2x2")
        }
    }

    private func subtitle(for category: String) -> String {
        switch category {
        case "Transport": return "Use public transportation instead of driving"
        case "Waste":     return "Reduce your waste generation"
        case "Energy":    return "Save electricity"
        case "Water":     return "Conserve water usage"
        default:          return "Custom eco-friendly action"
        }
    }
}
