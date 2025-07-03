//
//  TabBar.swift
//  Dinero
//
//  Created by Vinicius on 7/3/25.
//

import SwiftUI

struct TabBar: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var selectedTab: Int = 0
    @State private var isShowingAddView = false
    @Binding var angle: Double
    @Environment(\.colorScheme) var colorScheme
        
        let gradientColors = [Color.pink, Color.blue, Color.purple]
        
        var body: some View {
            ZStack {
                Group {
                    switch selectedTab {
                    case 0:
                        HomeView()
                    case 1:
                        Text("history")
                    case 2:
                        Text("settings")
                    default:
                        HomeView()
                    }
                }
                
                tabViewButtons
            }
            .ignoresSafeArea(.keyboard)
            .sheet(isPresented: $isShowingAddView) {
                AddView(viewModel: viewModel)
            }
        }
    }
    extension TabBar {
        
        var tabViewButtons: some View {
            VStack {
                Spacer()
                
                ZStack {
                
                    HStack(spacing: 15) {
                        HStack(spacing: 30) {
                            tabButton(icon: "dollarsign.bank.building", selectedIcon: "dollarsign.bank.building.fill", index: 0)
                            
                            tabButton(icon: "gearshape.fill", selectedIcon: "gearshape.fill", index: 2)
                        }
                        .frame(width: 80, height: 50)
                        .padding(.horizontal)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        
                        Button(action: {
                            isShowingAddView = true
                        }) {
                            animatedPlusButton
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }

    extension TabBar {
        @ViewBuilder
        func tabButton(icon: String, selectedIcon: String, index: Int) -> some View {
            Button(action: {
                selectedTab = index
            }) {
                Image(systemName: selectedTab == index ? selectedIcon : icon)
                    .font(.system(size: 25))
                    .foregroundColor(selectedTab == index ? .blue : .gray)
                    
            }
        }

        var animatedPlusButton: some View {
            ZStack {
                Circle()
                    .fill(Color(.blue))
                    .frame(width: 45, height: 45)

                Image(systemName: "plus")
                    .font(.system(size: 30))
                    .foregroundColor(.white)

                Circle()
                    .stroke(
                        AngularGradient(
                            colors: gradientColors,
                            center: .center,
                            angle: .degrees(angle)
                        ),
                        lineWidth: 3
                    )
                    .frame(width: 50, height: 50)

                Circle()
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [
                                .purple.opacity(0.8), .blue.opacity(0.9),
                                .pink.opacity(0.8), .purple.opacity(0.8)
                            ]),
                            center: .center,
                            angle: .degrees(angle)
                        ),
                        lineWidth: 3
                    )
                    .blur(radius: 4)
                    .frame(width: 50, height: 50)

                Circle()
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [
                                .purple.opacity(0.4), .blue.opacity(0.5),
                                .pink.opacity(0.4), .purple.opacity(0.4)
                            ]),
                            center: .center,
                            angle: .degrees(angle + 30)
                        ),
                        lineWidth: 8
                    )
                    .blur(radius: 5)
                    .frame(width: 50, height: 50)
            }
        }
        
        
    }



    #Preview {
        TabBar(angle: .constant(0))
            .environmentObject(ListViewModel())
    }
