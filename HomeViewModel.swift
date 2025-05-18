//
//  HomeViewModel.swift
//  Dinero
//
//  Created by Vinicius on 5/13/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var categories: [CategoryItemModel] = []
    @Published var banks: [BankItemModel] = []

    init() {
        loadDummyData() // carregar de JSON, banco, API etc.
    }

    func loadDummyData() {
        categories = [
            CategoryItemModel(category: "Compras", image: "basket.fill", value: "R$ 2454,00"),
            CategoryItemModel(category: "Transporte", image: "car.fill", value: "R$ 500,00")
        ]

        banks = [
            BankItemModel(bankName: "Nubank"),
            BankItemModel(bankName: "Banco do Brasil")
        ]
    }
}
