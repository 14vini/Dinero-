//
//  WelcomeView.swift
//  Dinero
//
//  Created by Vinicius on 5/7/25.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        NavigationStack{
            
            ZStack{
                Color(colorScheme == .dark ? .darkGray.withAlphaComponent(0.2) : .lightGray.withAlphaComponent(0.1))
                    .ignoresSafeArea(edges: .all)
                
                VStack{
                    VStack{
                        VStack{
                            
                            Image("logo")
                                .padding()
                            
                            Text("Bem-vindo ao")
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Text("Dinero")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.bottom)
                        }
                        .padding(.top)
                        .padding(.bottom, 40)
                        
                        Spacer()
                        // app features
                        
                        VStack(alignment: .leading, spacing: 30) {
                            CardStyle(icon: "sparkles", title: "Simples de usar", description: "Adicione transações de forma fácil.")
                            CardStyle(icon: "square.stack.3d.up.fill", title: "Organização", description: "Gerencie seu dinheiro com uma interface clara e organizada.")
                            CardStyle(icon: "shield.lefthalf.filled", title: "Segurança", description: "Seus dados estão protegidos e seguros.")
                        }.padding(10)
                        
                        
                        Spacer()
                        
                        //button
                        VStack{
                            ButtonStyle(title: "Continuar")
                        }
                    }
                }.padding(.horizontal)
            }.navigationBarBackButtonHidden()
        }
    }
    
    struct CardStyle: View{
        var icon : String
        var title: String
        var description: String
        
        var body : some View{
            
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.primary)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    struct ButtonStyle: View{
        
        var title: String
        
        @Environment(\.colorScheme) var colorScheme
        
        var body : some View{
            
            VStack{
                NavigationLink(destination: HomeView() ) {
                    Text(title)
                        .foregroundColor(.primary)
                        .frame(width: 250, height: 50)
                        .background(.ultraThinMaterial)
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.primary.opacity(0.2), lineWidth: 1)
                        )
                        .shadow(color: .primary.opacity(0.2) , radius: 5, x: 0 ,y: 3)
                        .padding(.bottom, 30)
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
