//
//  HomeViewModel.swift
//  Dinero
//
//  Created by Vinicius on 5/13/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var categories: [CategoryItemModel] = []
    @Published var banks: [BankItemModel] = []

    // Armazena bancos customizados adicionados pelo usuário
    @Published var customBanks: [Bank] = []

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
        // Evita duplicados
        if !customBanks.contains(customBank) {
            customBanks.append(customBank)
        }
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
        let uniqueBankNames = Set(transactions.map { $0.bank.rawValue })
        banks = uniqueBankNames.map { bankName in
            BankItemModel(bankName: bankName)
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
}
