//
//  AddView.swift
//  Dinero
//
//  Created by Vinicius on 5/16/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var description: String = ""
    @State private var amount: String = ""
    @State private var transactionType: TransactionType = .expense
    @State private var category: TransactionCategory = .food
    @State private var selectedDate = Date()
    @State private var paymentMethod: PaymentMethod = .cash
    @State private var linkedBank: Bank = .itau
    
    @State private var showingAddBankSheet = false
    @State private var newBankName = ""
    @State private var customBanks: [Bank] = []
    
    enum TransactionType: String, CaseIterable {
        case expense = "Despesa"
        case income = "Receita"
    }
    
    enum TransactionCategory: String, CaseIterable {
        case food = "Alimentação"
        case transport = "Transporte"
        case housing = "Moradia"
        case entertainment = "Lazer"
        case health = "Saúde"
        case other = "Outros"
    }
    
    enum PaymentMethod: String, CaseIterable {
        case cash = "Dinheiro"
        case creditCard = "Cartão de Crédito"
        case debitCard = "Cartão de Débito"
        case transfer = "Transferência"
    }
    
    enum Bank: String, CaseIterable, Identifiable {
        case itau = "Itaú"
        case bradesco = "Bradesco"
        case santander = "Santander"
        case nubank = "Nubank"
        case other = "Outro"
        
        var id: String { self.rawValue }
    }
    
    var allBanks: [Bank] {
        Bank.allCases.filter { $0 != .other } + customBanks
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.mainBackground
                    .ignoresSafeArea(edges: .all)
                Form {
                    Section(header: Text("INFORMAÇÃO BÁSICA")) {
                        TextField("Descrição", text: $description)
                        
                        HStack {
                            Text("R$")
                            TextField("0,00", text: $amount)
                                .keyboardType(.decimalPad)
                        }
                        
                        Picker("Tipo", selection: $transactionType) {
                            ForEach(TransactionType.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        
                        Picker("Categoria", selection: $category) {
                            ForEach(TransactionCategory.allCases, id: \.self) { cat in
                                Text(cat.rawValue).tag(cat)
                            }
                        }
                        
                        DatePicker("Data", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                    
                    Section(header: Text("INFORMAÇÃO ADICIONAL")) {
                        Picker("Método de pagamento", selection: $paymentMethod) {
                            ForEach(PaymentMethod.allCases, id: \.self) { method in
                                Text(method.rawValue).tag(method)
                            }
                        }
                        
                        Picker("Banco vinculado", selection: $linkedBank) {
                            ForEach(Bank.allCases, id: \.self) { bank in
                                Text(bank.rawValue).tag(bank)
                            }
                        }
                    }
                    
                    Section(header: Text("INFORMAÇÃO ADICIONAL").font(.headline)) {
                        Picker("Método de pagamento", selection: $paymentMethod) {
                            ForEach(PaymentMethod.allCases, id: \.self) { method in
                                Text(method.rawValue).tag(method)
                            }
                        }
                        
                        Picker("Banco vinculado", selection: $linkedBank) {
                            ForEach(allBanks, id: \.self) { bank in
                                Text(bank.rawValue).tag(bank)
                            }
                        }
                        .onChange(of: linkedBank) { newValue in
                            if newValue == .other {
                                showingAddBankSheet = true
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden) 
                .navigationTitle("Nova transação")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Adicionar") {
                            // ação de adicionar a transação
                        }
                        .frame(width: 100, height: 40)
                        .foregroundColor(.primary)
                        .background(Color(colorScheme == .dark ? .gray.opacity(0.1) : .white.opacity(0.5)))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.primary.opacity(0.2), lineWidth: 2)
                        )
                        
                    }
                }
            }
        }
    }
        
        private func saveTransaction() {
            // Implemente a lógica para salvar a transação aqui
            print("Transação salva:")
            print("Descrição: \(description)")
            print("Valor: \(amount)")
            print("Tipo: \(transactionType.rawValue)")
            print("Categoria: \(category.rawValue)")
            print("Data: \(selectedDate)")
            print("Método de pagamento: \(paymentMethod.rawValue)")
            print("Banco: \(linkedBank.rawValue)")
        }
    }

#Preview {
    AddView()
}
