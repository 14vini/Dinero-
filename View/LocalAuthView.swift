//
//  LocalAuthView.swift
//  Dinero
//
//  Created by Vinicius on 5/8/25.
//

import SwiftUI

struct LocalAuthView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isUnlocked: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.mainBackground
                    .ignoresSafeArea()

                VStack {
                    VStack {
                        Image(systemName: "lock.circle.fill")
                            .font(.system(size: 100))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .padding()

                        Text("App Bloqueado")
                            .font(.title2.bold())
                            .foregroundColor(.primary)

                        Text("Use o Face ID para desbloquear")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .padding(30)

                    Spacer()

                    VStack {
                        NavigationLink( destination: {
                            if isUnlocked {
                                HomeView()
                            }else{
                                HomeView()
                            }
                            
                        }
                        ) {
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: "lock.open.fill")
                                    .foregroundColor(.primary)

                                Text("Desbloquear")
                                    .foregroundColor(.primary)
                                    .font(.headline)
                            }
                            .frame(width: 300, height: 50)
                            .background(Color(colorScheme == .dark ? .gray.opacity(0.1) : .white.opacity(0.5)))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.primary.opacity(0.2), lineWidth: 2)
                            )
                        }
                        .padding(.bottom, 30)

                    
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        
        }
    }

#Preview {
    LocalAuthView()
}
