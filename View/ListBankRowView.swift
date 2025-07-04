//
//  ListBankRowView.swift
//  Dinero
//
//  Created by Vinicius on 6/7/25.
//

import SwiftUI

struct ListBankRowView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let bank: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack {
                HStack {
                    Image(systemName: "creditcard.fill")
                        .foregroundColor(.blue)
                    
                    Text(bank)
                    Spacer()
                    Text(value)
                        .bold()
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.primary.opacity(0.1), lineWidth: 1.5)
            )
            .shadow(color: .primary.opacity(0.2), radius: 3, x: 0, y: 0)
         
        }
    }
}

#Preview {
    ListBankRowView(bank: "Nubank", value: "R$ 1.234,56")
}
