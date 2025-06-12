//
//  HomeView.swift
//  Dinero
//
//  Created by Vinicius on 5/13/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = HomeViewModel()
    @State var showSettings = false
    @State var showAddView = false

    var body: some View {
        NavigationStack {
            ZStack {
                
                Color(colorScheme == .dark ? .darkGray.withAlphaComponent(0.2) : .lightGray.withAlphaComponent(0.1))
                    .ignoresSafeArea(edges: .all)
                
                ScrollView {
                    ModernStatusCard(balance: viewModel.balance, expenses: viewModel.totalExpenses)
                    styleData
                }
            }
            .navigationTitle("Início")
            .toolbar(content: toolbarContent)
            .sheet(isPresented: $showAddView) {
                AddView(viewModel: viewModel)
                
            }
            .navigationBarBackButtonHidden()
        }
    }
    
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {

        ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddView.toggle()
                } label: {
                    ToolbarButton(icon: "plus.circle")
                }
            }
        }
    }

// MARK: - Components

extension HomeView {
    var styleData : some View {
        VStack(spacing: 10) {
           // StatusCard(balance: viewModel.balance, income: viewModel.totalIncome, expenses: viewModel.totalExpenses)
         
            VStack(alignment: .leading, spacing: 10) {
                Text("Bancos adicionados:")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                ForEach(viewModel.banks) { bank in
                    BankCard(banco: bank.bankName)
                }
            }
            .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Categorias:")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                ForEach(viewModel.categories) { category in
                    ListCategoryRowView(
                        category: category.category,
                        image: category.image,
                        value: category.value
                    )
                }.onDelete(perform: viewModel.removeCategory)
            }.padding(.vertical)
        }.padding()
    }
    
    struct ModernStatusCard: View {
        var balance: Double
        var expenses: Double
        
        var body: some View {
            
            VStack(alignment: .leading, spacing: 16) {
                
                VStack{
                    Text("BemVindo!")
                        .font(.title2.bold())
                    
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Saldo total:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(balance.formatCurrency())
                            .font(.title2.bold())
                            .foregroundColor(.green)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Despesa Total:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(expenses.formatCurrency())
                            .font(.title2.bold())
                            .foregroundColor(.blue)
                    }
                }
                
            }
            .padding(30)
        }
    }

    struct ToolbarButton: View {
        var icon: String

        var body: some View {
            Image(systemName: icon)
                .foregroundColor(.primary)
                .font(.title3)
                .padding(.vertical)
                
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
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                )
                .shadow(color: .primary.opacity(0.2), radius: 2 , x: 0, y: 1)
            }
        }
    }
}

// MARK: - Extensions

extension Double {
    func formatCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: self)) ?? "R$ 0,00"
    }
}

#Preview {
    HomeView()
}
