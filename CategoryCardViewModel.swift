//
//  CategoryCardViewModel.swift
//  Dinero
//
//  Created by Vinicius on 5/12/25.
//

import SwiftUI

struct CategoryCardViewModel: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
    
    var categort = []
        
    let category : String
    let image : String
    let value : String
        
        VStack(alignment: .leading, spacing: 10) {
            VStack{
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
            .background(Color(colorScheme == .dark ? .gray.opacity(0.05) : .white.opacity(0.5)))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
            )
        }
    }
}

#Preview {
    CategoryCardViewModel(category: "Compras", image:  "basket.fill", value: "RS 2454,00")
}
