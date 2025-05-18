//
//  HomeView.swift
//  Dinero
//
//  Created by Vinicius on 5/8/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea(edges: .all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // STATUS CARD
                        StatusCard()
                        
                        HStack {
                            Image(systemName: "sparkles")
                            Text("Calma aí, o mês ainda não acabou!")
                                .font(.footnote)
                        }
                        .foregroundColor(.gray)
                        
                        // BANK CARD
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Bancos")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            ForEach(viewModel.banks) { bank in
                                BankCard(banco: bank.bankName)
                            }
                        }
                        .padding(.bottom)
                        .padding(.top)
                        
                        // CATEGORIES CARD
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Categorias")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            ForEach(viewModel.categories) { category in
                                ListCategoryRowView(
                                    category: category.category,
                                    image: category.image,
                                    value: category.value
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .navigationTitle("Início")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: SettingView() ) {
                        ToolbarButton(icon: "gearshape")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddView() ) {
                        ToolbarButton(icon: "plus.circle")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct StatusCard: View {
  
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
        
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
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )
        
    }
    
}

struct ToolbarButton: View {
    var icon : String
    
    var body: some View {
        Image(systemName: icon)
            .foregroundColor(.primary)
            .font(.title3)
            .padding(.top)
            .padding(.bottom)
    }
}

struct BankCard: View{
    @Environment(\.colorScheme) var colorScheme
    
    var banco : String
    
    var body: some View {
        
        VStack{
            
            HStack {
                Text(banco)
                    .padding()
                Spacer()
            }
            .padding(.horizontal)
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
    HomeView()
}
