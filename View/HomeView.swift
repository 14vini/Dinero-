//
//  HomeView.swift
//  Dinero
//
//  Created by Vinicius on 5/8/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.mainBackground)
                    .ignoresSafeArea(edges: .all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // STATUS CARD
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                VStack{
                                    Image(systemName: "banknote")
                                        .foregroundColor(.red)
                                        .font(.largeTitle)
                                    Spacer()
                                    Text("Status")
                                        .font(.title.bold())
                                }
                                
                                Spacer()
                                
                                Text("-R$ 2.454,00")
                                    .font(.title.bold())
                                
                            }
                            
                            Divider()
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Label("Ganhos", systemImage: "arrow.down")
                                        .foregroundColor(.green)
                                        .font(.headline.bold())
                                    Text("R$ 0,00")
                                        .font(.headline)
                                }
                                Spacer()
                                VStack(alignment: .leading) {
                                    Label("Despesas", systemImage: "arrow.up")
                                        .foregroundColor(.red)
                                        .font(.headline.bold())
                                    Text("R$ 2.454,00")
                                        .font(.headline)
                                }
                            }
                            .padding(.bottom, 5)
                            .padding(.top)
                        }
                        .padding(30)
                        .background(Color(colorScheme == .dark ? .gray.opacity(0.05) : .white.opacity(0.5)))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                        )
                    }.padding(.bottom)
                    
                    HStack {
                        Image(systemName: "sparkles")
                        Text("Calma aí, o mês ainda não acabou!")
                            .font(.footnote)
                    }
                    .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Bancos")
                            .font(.headline)
                        HStack {
                            Text("Bradesco")
                                .padding()
                            Spacer()
                        }
                        .padding(.horizontal)
                        .frame(height: 50)
                        .background(Color(colorScheme == .dark ? .gray.opacity(0.05) : .white.opacity(0.5)))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                        )
                    }
                    .padding(.bottom)
                    .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Categorias")
                            .font(.headline)
                        VStack{
                            HStack {
                                
                                Image(systemName: "basket.fill")
                                    .foregroundColor(.red)
                                Text("Compras")
                                Spacer()
                                Text("R$ 2.454,00")
                                    .bold()
                            }
                            Spacer()
                            HStack {
                                
                                Image(systemName: "basket.fill")
                                    .foregroundColor(.red)
                                Text("Compras")
                                Spacer()
                                Text("R$ 2.454,00")
                                    .bold()
                            }
                            
                        }
                        .padding(.horizontal)
                        .padding(.vertical)
                        .background(Color(colorScheme == .dark ? .gray.opacity(0.05) : .white.opacity(0.5)))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                       )
                    }
           
                    
                }.padding(.horizontal)
            }
            .navigationTitle("Início")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: Text("congiguraçoes")){
                        ToolbarButtonStyle(icon: "gearshape")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Text("add")) {
                        ToolbarButtonStyle(icon: "plus.circle")
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden()
    }
}

struct ToolbarButtonStyle: View {
    var icon : String
    
    var body: some View {
        Image(systemName: icon)
            .foregroundColor(.primary)
            .font(.title3)
            .padding(.top)
            .padding(.bottom)
    }
}

struct CardStyle: View{
    @Environment(\.colorScheme) var colorScheme
    
    var width : CGFloat
    var heiht : CGFloat
    
    var body: some View {
        
        VStack{
            
        }
        .frame(width: 350, height: 300, alignment: .center)
        .background(Color(colorScheme == .dark ? .black : .white).opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.primary.opacity(0.1), lineWidth: 3)
        )
    }
       

    
}

#Preview {
    HomeView()
}
