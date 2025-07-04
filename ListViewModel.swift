//
//  ListViewModel.swift
//  Dinero
//
//  Created by Vinicius on 5/13/25.
//

import Foundation

enum UnifiedItemModel: Identifiable {
    case category(CategoryItemModel)
    case bank(BankItemModel)
    
    var id: String {
        switch self {
        case .category(let item):
            return item.id
        case .bank(let item):
            return item.id
        }
    }
}

class ListViewModel: ObservableObject {
    @Published var items: [UnifiedItemModel] = []

    init() {
        loadItems()
    }

    func loadItems() {
        let categoryItems = [
            CategoryItemModel(category: "Alimentação", image: "🍔", value: "50"),
            CategoryItemModel(category: "Transporte", image: "🚌", value: "20")
        ].map { UnifiedItemModel.category($0) }

        let bankItems = [
            BankItemModel(bankName: "Nubank", bankValue: "1200"),
            BankItemModel(bankName: "Banco do Brasil", bankValue: "1200")
        ].map { UnifiedItemModel.bank($0) }

        self.items = categoryItems + bankItems
    }
}
