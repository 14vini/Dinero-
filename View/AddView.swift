//
//  AddView.swift
//  Dinero
//
//  Created by Vinicius on 5/16/25.
//
import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HomeViewModel
    
    // Estados do formulário
    @State private var description: String = ""
    @State private var amount: String = ""
    @State private var transactionType: TransactionType = .expense
    @State private var category: TransactionCategory = .food
    @State private var selectedDate = Date()
    @State private var paymentMethod: PaymentMethod = .cash
    @State private var linkedBank: Bank = .itau
    
    // Estados para adicionar novo banco
    @State private var showingAddBankSheet = false
    @State private var newBankName = ""
    @State private var customBanks: [Bank] = []
    
    // Validação
    @State private var showingError = false
    @State private var errorMessage = ""
    
    var allBanks: [Bank] {
        Bank.allCases.filter { $0 != .other } + customBanks
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.mainBackground
                    .ignoresSafeArea()
                
                Form {
                    Section(header: Text("INFORMAÇÃO BÁSICA").font(.headline)) {
                        TextField("Descrição", text: $description)
                            .autocapitalization(.sentences)
                        
                        HStack {
                            Text("R$")
                            TextField("0,00", text: $amount)
                                .keyboardType(.decimalPad)
                                .onChange(of: amount) { newValue in
                                    validateAmount(newValue)
                                }
                        }
                        
                        Picker("Tipo", selection: $transactionType) {
                            ForEach(TransactionType.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Picker("Categoria", selection: $category) {
                            ForEach(TransactionCategory.allCases, id: \.self) { cat in
                                Text(cat.rawValue).tag(cat)
                            }
                        }
                        
                        DatePicker("Data", selection: $selectedDate, displayedComponents: .date)
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
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") {
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Salvar") {
                            saveTransaction()
                        }
                        .disabled(!isFormValid)
                    }
                }
                .alert("Erro", isPresented: $showingError) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(errorMessage)
                }
                .sheet(isPresented: $showingAddBankSheet) {
                    addNewBankView
                }
            }
        }
    }
    
    // MARK: - View Components
    private var addNewBankView: some View {
        NavigationStack {
            Form {
                TextField("Nome do banco", text: $newBankName)
                    .autocapitalization(.words)
            }
            .navigationTitle("Novo Banco")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        newBankName = ""
                        showingAddBankSheet = false
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Adicionar") {
                        addCustomBank()
                    }
                    .disabled(newBankName.isEmpty)
                }
            }
        }
        .presentationDetents([.medium])
    }
    
    // MARK: - Validação
    private var isFormValid: Bool {
        !description.isEmpty && !amount.isEmpty && Double(amount) != nil
    }
    
    private func validateAmount(_ value: String) {
        if value.contains(",") {
            amount = value.replacingOccurrences(of: ",", with: ".")
        }
    }
    
    // MARK: - Ações
    private func addCustomBank() {
        let customBank = Bank.custom(newBankName)
        customBanks.append(customBank)
        linkedBank = customBank
        newBankName = ""
        showingAddBankSheet = false
    }
    
    private func saveTransaction() {
        guard let amountValue = Double(amount) else {
            errorMessage = "Valor inválido. Use números decimais (ex: 150.50)"
            showingError = true
            return
        }
        
        guard !description.isEmpty else {
            errorMessage = "Por favor, insira uma descrição"
            showingError = true
            return
        }
        
        let newTransaction = Transaction(
            description: description,
            amount: amountValue,
            type: transactionType,
            category: category,
            date: selectedDate,
            paymentMethod: paymentMethod,
            bank: linkedBank
        )
        
        viewModel.addTransaction(newTransaction)
        dismiss()
    }
}

// Extensão para bancos customizados
extension Bank {
    static func custom(_ name: String) -> Bank {
        Bank(rawValue: name) ?? .other
    }
}

// Preview
#Preview {
    AddView(viewModel: HomeViewModel())
        .environment(\.locale, Locale(identifier: "pt_BR"))
}
