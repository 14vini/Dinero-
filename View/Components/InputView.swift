//
//  InputView.swift
//  Dinero
//
//  Created by Vinicius on 5/6/25.
//
import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    
    private let title: String
    private let placeholder: String
    private let isSecurityField: Bool

    init(text: Binding<String>, title: String, placeholder: String, isSecurityField: Bool = false) {
        self._text = text
        self.title = title
        self.placeholder = placeholder
        self.isSecurityField = isSecurityField
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if isSecurityField {
                SecureField(placeholder, text: $text)
                    .padding()
                    .background(Color(.black).opacity(0.5))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.primary.opacity(0.1), lineWidth: 2)
                    )
            } else {
                TextField(placeholder, text: $text)
                    .padding()
                    .background(Color(.black).opacity(0.5))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.primary.opacity(0.1), lineWidth: 2)
                    )
            }
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Nome", placeholder: "Digite seu nome")
}
