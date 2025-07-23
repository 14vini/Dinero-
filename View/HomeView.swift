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
                
                ScrollView {
                    ModernStatusCard(balance: viewModel.balance, expenses: viewModel.totalExpenses)
                    styleData
                }
            }
            .navigationTitle("Início")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar(content: toolbarContent)
            .sheet(isPresented: $showAddView) {
                AddView(viewModel: viewModel)
                    .presentationDetents([.medium, .large])
                    .presentationCornerRadius(40)
            }
            .navigationBarBackButtonHidden()
        }
    }
    
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {

        ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddView.toggle()
                    viewModel.feedbackHapitcs()
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
                    ListBankRowView(bank: bank.bankName, value: bank.bankValue)
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
            ZStack {
                
                // Background Circles
                ZStack {
                    Circle()
                        .fill(.yellow.opacity(0.9))
                        .offset(x: 130, y: -80)
                       
                    Circle().fill(.blue.opacity(0.9))
                        .offset(x: -130, y: 80)
                }.blur(radius: 20)

                // Main Content
                VStack(alignment: .leading, spacing: 20) {
                    VStack {
                        Text(balance.formatCurrency())
                            .font(.title2)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundColor(.primary)
                        Text("Saldo total")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    VStack {
                        Text(expenses.formatCurrency())
                            .font(.title2)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundColor(.red)
                        Text("Despesa Total")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(maxWidth: 300)
            .frame(height: 150)
            .glass(radius: 20)
            .padding()
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
