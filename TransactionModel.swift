//
//  TransactionModel.swift
//  Dinero
//
//  Created by Vinicius on 5/14/25.
//

import Foundation

enum TransactionType: String {
    case debit = "debit"
    case credit = "credit"
}

struct TransactionModel: Identifiable {
    let id: Int
    let institution: String
    let account: String
    var merchant: String
    let amount: Double
    let type: TransactionType
    var category: String
    let isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
}


