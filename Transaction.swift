//
//  Transaction.swift
//  Dinero
//
//  Created by Vinicius on 5/20/25.
//

import Foundation

struct Transaction: Identifiable, Codable, Hashable {
    let id: UUID
    let description: String
    let amount: Double
    let type: TransactionType
    let category: TransactionCategory
    let date: Date
    let paymentMethod: PaymentMethod
    let bank: Bank
    
    init(id: UUID = UUID(),
         description: String,
         amount: Double,
         type: TransactionType,
         category: TransactionCategory,
         date: Date,
         paymentMethod: PaymentMethod,
         bank: Bank) {
        self.id = id
        self.description = description
        self.amount = amount
        self.type = type
        self.category = category
        self.date = date
        self.paymentMethod = paymentMethod
        self.bank = bank
    }
}

// Enums reutilizáveis em todo o app
enum TransactionType: String, CaseIterable, Codable {
    case expense = "Despesa"
    case income = "Ganho"
}

enum TransactionCategory: String, CaseIterable, Codable {
    case food = "Alimentação"
    case transport = "Transporte"
    case housing = "Moradia"
    case entertainment = "Lazer"
    case health = "Saúde"
    case other = "Outros"
}

enum PaymentMethod: String, CaseIterable, Codable {
    case cash = "Dinheiro"
    case creditCard = "Cartão de Crédito"
    case debitCard = "Cartão de Débito"
    case transfer = "Transferência"
}

enum Bank: String, CaseIterable, Codable, Identifiable {
    case itau = "Itaú"
    case bradesco = "Bradesco"
    case santander = "Santander"
    case nubank = "Nubank"
    case bancoDoBrasil = "Banco do Brasil"
    case caixa = "Caixa Econômica Federal"
    case inter = "Banco Inter"
    case original = "Banco Original"
    case c6 = "C6 Bank"
    case btg = "BTG Pactual"
    case neon = "Banco Neon"
    case pagbank = "PagBank"
    case next = "Next"
    case sicredi = "Sicredi"
    case sicoob = "Sicoob"
    case banrisul = "Banrisul"
    case bancoPan = "Banco PAN"
    case mercantil = "Banco Mercantil"
    case alfa = "Banco Alfa"
    case safra = "Banco Safra"
    case digio = "Digio"
    case willbank = "Will Bank"
    case bmg = "Banco BMG"
    case modal = "ModalMais"
    case agibank = "Agibank"
    case bancoTopazio = "Banco Topázio"
    case bancoRendimento = "Banco Rendimento"
    case bancoDaycoval = "Banco Daycoval"
    case bancoVolkswagen = "Banco Volkswagen"
    case bancoToyota = "Banco Toyota"
    case other = "Outro"

    var id: String { self.rawValue }
}

extension Transaction {
    static var mock: Transaction {
        Transaction(
            description: "Supermercado",
            amount: 150.50,
            type: .expense,
            category: .food,
            date: Date(),
            paymentMethod: .creditCard,
            bank: .itau
        )
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }()

    var formattedDate: String {
        Self.dateFormatter.string(from: date)
    }

    private static let amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }()

    var formattedAmount: String {
        Self.amountFormatter.string(from: NSNumber(value: amount)) ?? "R$ 0,00"
    }
}
