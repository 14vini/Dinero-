//
//  ItemsModel.swift
//  Dinero
//
//  Created by Vinicius on 5/13/25.
//

import Foundation

// imutable Struct
struct CategoryItemModel: Identifiable, Codable {
    
    var id: String
    let category: String
    let image: String
    let value: String
    
    init(id: String = UUID().uuidString , category: String, image: String, value: String){
        self.id = UUID().uuidString
        self.category = category
        self.image = image
        self.value = value
        
        
    }
    
    func updateComptetion() -> CategoryItemModel {
        return CategoryItemModel(id: id, category: category, image: image, value: value)
    }
}

struct BankItemModel: Identifiable, Codable {
    
    var id: String
    let bankName: String
    
    init(id: String = UUID().uuidString , bankName: String){
        self.id = id
        self.bankName = bankName
        
    }
    
    func updateComptetion() -> BankItemModel {
        return BankItemModel(id: id, bankName: bankName)
    }
}
