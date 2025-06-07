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

    var body: some View {
        NavigationStack {
            ZStack {
                Color(colorScheme == .dark ? .darkGray.withAlphaComponent(0.2) : .lightGray.withAlphaComponent(0.1))
                    .ignoresSafeArea(edges: .all)

                ScrollView {
                    VStack(spacing: 20) {
                        StatusCard(balance: viewModel.balance, income: viewModel.totalIncome, expenses: viewModel.totalExpenses)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Bancos")
                                .font(.headline)
                                .foregroundColor(.primary)

                            ForEach(viewModel.banks) { bank in
                                BankCard(banco: bank.bankName)
                            }
                        }
                        .padding(.vertical)

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
            .toolbar(content: toolbarContent)
            .sheet(isPresented: $showSettings) {
                SettingView()
            }
        }
        .navigationBarBackButtonHidden()
    }

    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
//        ToolbarItem(placement: .navigationBarLeading) {
//            Menu {
//                Button("Perfil", action: { print("Perfil") })
//
//                Button("Configurações", action: {
//                    showSettings.toggle()
//                })
//
//                Button("Sair", action: { print("Logout") })
//
//            } label: {
//                ToolbarButton(icon: "line.3.horizontal")
//            }
//        }

        ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink(destination: AddView(viewModel: viewModel)) {
                ToolbarButton(icon: "plus.circle")
            }
        }
    }
}

// MARK: - Components

extension HomeView {
    struct StatusCard: View {
        @Environment(\.colorScheme) var colorScheme
        var balance: Double
        var income: Double
        var expenses: Double

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

                    Text(balance.formatCurrency())
                        .font(.title.bold())
                }

                Divider()

                HStack {
                    VStack(alignment: .leading) {
                        Label("Ganhos", systemImage: "arrow.down")
                            .foregroundColor(.green)
                            .font(.headline.bold())
                        Text(income.formatCurrency())
                            .font(.headline)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Label("Despesas", systemImage: "arrow.up")
                            .foregroundColor(.red)
                            .font(.headline.bold())
                        Text(expenses.formatCurrency())
                            .font(.headline)
                    }
                }
                .padding(.vertical, 5)
            }
            .padding(30)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
            )
            .shadow(color: .primary.opacity(0.2), radius: 5, x: 0, y: 1)
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
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                )
                .shadow(color: .primary.opacity(0.2), radius: 3, x: 0, y: 1)
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
