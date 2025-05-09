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
                Color(.mainBackground)
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
                            CardStyle(icon: "faceid", title: "Segurança", description: "Seus dados ficam salvo no Iphone com face ID.")
                                
                        }.padding(30
                        )
                        
                        Spacer()
                        //button
                        VStack{
                            NavigationLink(destination: LocalAuthView() ) {
                                Text("Continuar")
                                    .foregroundColor(.primary)
                                    .font(.headline)
                                    .frame(width: 300, height: 50)
                                    .background(Color(colorScheme == .dark ? .gray.opacity(0.1) : .white.opacity(0.5)))
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.primary.opacity(0.2), lineWidth: 2)
                                    ).padding(.bottom, 30)
                                
                            }
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
            
            HStack{
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                
                VStack(alignment: .leading, spacing: 4){
                    Text(title)
                        .fontWeight(.semibold)
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
            }
        }
    }
}

#Preview {
    WelcomeView()
}
