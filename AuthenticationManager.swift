//
//  AuthenticationManager.swift
//  Dinero
//
//  Created by Vinicius on 5/9/25.
//

import LocalAuthentication
import Foundation

class AuthenticationManager: ObservableObject {
    @Published var isUnlocked: Bool = false

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock your app"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // houve um erro na autenticação
                        print("Erro na autenticação: \(error?.localizedDescription ?? "Desconhecido")")
                    }
                }
            }
        } else {
            // dispositivo não suporta biometria
            print("Biometria não disponível: \(error?.localizedDescription ?? "Desconhecido")")
        }
    }
}
