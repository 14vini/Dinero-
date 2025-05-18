//
//  SettingView.swift
//  Dinero
//
//  Created by Vinicius on 5/16/25.
//

import SwiftUI

struct SettingView: View {
    @State private var isAppLocked = true
    @State private var isExpenseOnly = false
    @State private var iconStyle = "Padrão"
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color(.mainBackground)
                    .ignoresSafeArea(edges: .all)
                
                Form {
                    // CONFIGURAÇÕES RÁPIDAS
                    Section(header: Text("CONFIGURAÇÕES RÁPIDAS")) {
                        Toggle("Bloquear app", isOn: $isAppLocked)
                        Toggle("Modo só despesas", isOn: $isExpenseOnly)
                        
                        Picker("Ícone", selection: $iconStyle) {
                            Text("Padrão").tag("Padrão")
                            // Adicione outras opções se necessário
                        }
                        
                        Button(role: .destructive) {
                            // apagar transações
                        } label: {
                            Text("Apagar todas as transações")
                        }
                        
                        Text("Ao clicar no botão acima, ação não poderá ser desfeita.")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    // METAS
                    Section(header: Text("METAS")) {
                        HStack {
                            Text("Ganhos:")
                            Spacer()
                            Text("R$ 0,00")
                        }
                        HStack {
                            Text("Despesas:")
                            Spacer()
                            Text("R$ 0,00")
                        }
                    }
                    
                    // FEEDBACK & COMPARTILHAMENTO
                    Section(header: Text("FEEDBACK & COMPARTILHAMENTO")) {
                        Link("Compartilhar o MoneeBuddy", destination: URL(string: "https://example.com")!)
                        Link("Feedback", destination: URL(string: "https://example.com")!)
                        
                        Text("Seu feedback é importante!")
                            .font(.caption)
                            .foregroundColor(.gray)
                            
                    }
                }
                .scrollContentBackground(.hidden) 
                .navigationTitle("Configurações")
            }
        }
    }
}

#Preview {
    SettingView()
}
