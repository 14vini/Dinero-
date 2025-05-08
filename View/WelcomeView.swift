//
//  WelcomeView.swift
//  Dinero
//
//  Created by Vinicius on 5/7/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack{
            Color(.mainBackground)
                .ignoresSafeArea(edges: .all)
            
            VStack{
                VStack{
                    Image("logo")
                    
                    Text("Bem-vindo ao")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text("Dinero")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom)
                }
                .padding()
                
                // app features
                VStack(alignment: .leading, spacing: 30) {
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "sparkles")
                            .font(.largeTitle)
                            .foregroundColor(.primary)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Funcionalidade Inteligente")
                                .fontWeight(.semibold)
                            Text("Use recursos inteligentes que ajudam você a economizar automaticamente.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }

                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "square.stack.3d.up")
                            .font(.largeTitle)
                            .foregroundColor(.primary)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Organização")
                                .fontWeight(.semibold)
                            Text("Gerencie seu dinheiro com uma interface clara e intuitiva.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }

                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "faceid")
                            .font(.largeTitle)
                            .foregroundColor(.primary)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Segurança Avançada")
                                .fontWeight(.semibold)
                            Text("Seus dados ficam salvo no Iphone com requisição do face ID.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom, 50)
                
                NavigationLink(destination: Text("Nova tela")) {
                    Text("Continuar")
                        .foregroundColor(.black)
                        .font(.headline)
                        .frame(width: 300, height: 50)
                        .background(
                            Color.white.opacity(0.7)
                                .background(.ultraThinMaterial)
                                )
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.primary.opacity(0.2), lineWidth: 2)
                        )

                }
            

            }
            
        }
    }
}

#Preview {
    WelcomeView()
}
