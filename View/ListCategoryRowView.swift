//
//  ListCategoryRowView.swift
//  Dinero
//
//  Created by Vinicius on 5/13/25.
//

import SwiftUI

struct ListCategoryRowView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let category: String
    let image: String
    let value: String

    // Computed property para retornar uma cor com base na categoria
    var categoryColor: Color {
        switch category.lowercased() {
        case "alimentação", "food":
            return .green
        case "transporte", "transport":
            return .blue
        case "moradia", "housing":
            return .orange
        case "entretenimento", "entertainment":
            return .purple
        case "saúde", "health":
            return .red
        case "outros", "other":
            return .gray
        default:
            return .accentColor
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack {
                HStack {
                    Image(systemName: image)
                        .foregroundColor(categoryColor)
                    Text(category)
                    Spacer()
                    Text(value)
                        .bold()
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
            )
            .shadow(color: .primary.opacity(0.2), radius: 1.5, x: 0, y: 1)
        }
    }
}

#Preview {
    ListCategoryRowView(category: "Food", image: "basket.fill", value: "R$ 2.454,00")
}
