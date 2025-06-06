//
//  HomeViewModel.swift
//  Dinero
//
//  Created by Vinicius on 5/13/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    // Dados publicados
    @Published var transactions: [Transaction] = []
    @Published var categories: [CategoryItemModel] = []
    @Published var banks: [BankItemModel] = []
    
    // Dados calculados
    var totalExpenses: Double {
        transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
    }
    
    var totalIncome: Double {
        transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
    }
    
    var balance: Double {
        totalIncome - totalExpenses
    }

    init() {
        loadDummyData()
    }

    func loadDummyData() {
        // 1. Carrega bancos fictícios
        banks = [
            BankItemModel(bankName: "Nubank"),
            BankItemModel(bankName: "Banco do Brasil")
        ]
        
        // 2. Carrega transações fictícias (opcional)
        let dummyTransactions = [
            Transaction(description: "Mercado", amount: 245.0, type: .expense, category: .food, date: Date(), paymentMethod: .creditCard, bank: .nubank),
            Transaction(description: "Uber", amount: 25.0, type: .expense, category: .transport, date: Date(), paymentMethod: .debitCard, bank: .itau),
            Transaction(description: "Salário", amount: 3000.0, type: .income, category: .other, date: Date(), paymentMethod: .transfer, bank: .itau)
        ]
        
        transactions = dummyTransactions
        updateAllData()
    }
    
    func addTransaction(_ transaction: Transaction) {
        // 1. Adiciona à lista de transações
        transactions.append(transaction)
        
        // 2. Atualiza todos os dados derivados
        updateAllData()
        
        print("Transação adicionada: \(transaction.description)")
    }
    
    private func updateAllData() {
        // Atualiza categorias
        updateCategories()
        
        // Atualiza bancos (opcional)
        updateBanks()
    }
    
    private func updateCategories() {
        // Agrupa gastos por categoria
        var categoryExpenses: [TransactionCategory: Double] = [:]
        
        for transaction in transactions where transaction.type == .expense {
            categoryExpenses[transaction.category] = (categoryExpenses[transaction.category] ?? 0) + transaction.amount
        }
        
        // Converte para CategoryItemModel
        categories = categoryExpenses.map { category, total in
            CategoryItemModel(
                category: category.rawValue,
                image: imageForCategory(category),
                value: formatCurrency(total)
            )
        }
    }
    
    private func updateBanks() {
        // Adiciona novos bancos das transações
        let uniqueBankNames = Set(transactions.map { $0.bank.rawValue })
        
        banks = uniqueBankNames.map { bankName in
            BankItemModel(bankName: bankName)
        }
    }
    
    // MARK: - Helpers
    private func imageForCategory(_ category: TransactionCategory) -> String {
        switch category {
        case .food: return "basket.fill"
        case .transport: return "car.fill"
        case .housing: return "house.fill"
        case .entertainment: return "film.fill"
        case .health: return "heart.fill"
        case .other: return "tag.fill"
        }
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
    }
}
