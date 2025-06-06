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
    @State var showSettings = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea(edges: .all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // STATUS CARD
                        StatusCard()
                        
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
                    Button(action: {
                        showSettings.toggle()
                    }) {
                        ToolbarButton(icon: "gearshape")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddView(viewModel: viewModel)) {
                        ToolbarButton(icon: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingView()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct StatusCard: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack {
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
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.primary.opacity(0.1), lineWidth: 2)
        )
        
    }
}

struct ToolbarButton: View {
    var icon: String
    
    var body: some View {
        Image(systemName: icon)
            .foregroundColor(.primary)
            .font(.title3)
            .padding(.top)
            .padding(.bottom)
    }
}

struct BankCard: View {
    @Environment(\.colorScheme) var colorScheme
    var banco: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "creditcard.fill")
                    .foregroundColor(.cyan)

                Text(banco)
                    .padding()
                Spacer()
            }
            .padding(.horizontal)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary.opacity(0.1), lineWidth: 2)
            )
        }
    }
}

#Preview {
    HomeView()
}
