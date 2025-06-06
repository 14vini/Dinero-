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
                Color.background
                    .ignoresSafeArea(edges: .all)
                
                VStack{
                    VStack{
                        VStack{
                            
                            Image("logo")
                                .padding(.bottom)
                            
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
                            CardStyle(icon: "faceid", title: "Segurança", description: "Seus dados ficam salvos no iPhone com Face ID.")
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
                NavigationLink(destination: LocalAuthView() ) {
                    Text(title)
                        .foregroundColor(.primary)
                        .frame(width: 300, height: 50)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.primary.opacity(0.5), lineWidth: 2)
                        ).padding(.bottom, 30)
                }   
            }
        }
    }
}

#Preview {
    WelcomeView()
}
