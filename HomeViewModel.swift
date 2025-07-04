//
//  HomeViewModel.swift
//  Dinero
//
//  Created by Vinicius on 5/13/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var transactions: [Transaction] = [] {
        didSet {
            saveTransactions()
        }
    }
    
    @Published var customBanks: [Bank] = [] {
        didSet {
            saveCustomBanks()
        }
    }

    @Published var categories: [CategoryItemModel] = []
    @Published var banks: [BankItemModel] = []

    private let transactionsKey = "SavedTransactions"
    private let customBanksKey = "SavedCustomBanks"
    private let categoriesKey = "SavedCategories"

    init() {
        loadTransactions()
        loadCustomBanks()
        loadCategories()
        updateAllData()
    }

    var totalExpenses: Double {
        transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
    }

    var totalIncome: Double {
        transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
    }

    var balance: Double {
        totalIncome - totalExpenses
    }

    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
        updateAllData()
        print("Transação adicionada: \(transaction.description)")
    }

    func addCustomBank(_ name: String) {
        let customBank = Bank.custom(name)
        if !customBanks.contains(customBank) {
            customBanks.append(customBank)
        }
    }

    // MARK: - Salvar e carregar dados

    private func saveTransactions() {
        if let encoded = try? JSONEncoder().encode(transactions) {
            UserDefaults.standard.set(encoded, forKey: transactionsKey)
        }
    }

    private func loadTransactions() {
        if let data = UserDefaults.standard.data(forKey: transactionsKey),
           let decoded = try? JSONDecoder().decode([Transaction].self, from: data) {
            transactions = decoded
        }
    }

    private func saveCustomBanks() {
        if let encoded = try? JSONEncoder().encode(customBanks) {
            UserDefaults.standard.set(encoded, forKey: customBanksKey)
        }
    }

    private func loadCustomBanks() {
        if let data = UserDefaults.standard.data(forKey: customBanksKey),
           let decoded = try? JSONDecoder().decode([Bank].self, from: data) {
            customBanks = decoded
        }
    }

    private func saveCategories() {
        if let encoded = try? JSONEncoder().encode(categories) {
            UserDefaults.standard.set(encoded, forKey: categoriesKey)
        }
    }

    private func loadCategories() {
        if let data = UserDefaults.standard.data(forKey: categoriesKey),
           let decoded = try? JSONDecoder().decode([CategoryItemModel].self, from: data) {
            categories = decoded
        }
    }

    // MARK: - Lógica de categorias e bancos

    func removeCategory(at offsets: IndexSet) {
        categories.remove(atOffsets: offsets)
        saveCategories()
        calculateTotals()
    }

    private func updateAllData() {
        updateCategories()
        updateBanks()
    }

    private func updateCategories() {
        var categoryExpenses: [TransactionCategory: Double] = [:]
        for transaction in transactions where transaction.type == .expense {
            categoryExpenses[transaction.category] = (categoryExpenses[transaction.category] ?? 0) + transaction.amount
        }

        categories = categoryExpenses.map { category, total in
            CategoryItemModel(
                category: category.rawValue,
                image: imageForCategory(category),
                value: formatCurrency(total)
            )
        }
    }

    private func updateBanks() {
        var bankTotals: [String: Double] = [:]
        
        for transaction in transactions {
            let bankName = transaction.bank.rawValue
            bankTotals[bankName, default: 0] += transaction.amount
        }
        
        banks = bankTotals.map { bankName, total in
            BankItemModel(
                bankName: bankName,
                bankValue: formatCurrency(total)
            )
        }
    }

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

    func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
    }
    
    private func calculateTotals() {
        // Aqui você pode recalcular alguma métrica se necessário
    }
}
