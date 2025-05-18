//
//  PreviewData.swift
//  Dinero
//
//  Created by Vinicius on 5/14/25.
//

import Foundation

var transactionPreviewData = TransactionModel(
    id: 1,
    institution: "Banco XP",
    account: "Conta Corrente",
    merchant: "Apple Store",
    amount: 199.99,
    type: .debit,
    category: "Tecnologia",
    isPending: false,
    isTransfer: false,
    isExpense: true,
    isEdited: false
)

var transactionListPreviewData = Array(repeating: transactionPreviewData, count: 10)
