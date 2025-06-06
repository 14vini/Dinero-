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

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack {
                HStack {
                    Image(systemName: image)
                        .foregroundColor(.red)
                    Text(category)
                    Spacer()
                    Text(value)
                        .bold()
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary.opacity(0.1), lineWidth: 2)
            )
        }
    }
}

#Preview {
    ListCategoryRowView(category: "Compras", image: "basket.fill", value: "R$ 2.454,00")
}
