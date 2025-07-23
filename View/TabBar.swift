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
                            
                            tabButton(icon: "chart.line.uptrend.xyaxis", selectedIcon: "chart.line.uptrend.xyaxis", index: 1)
                            
                            tabButton(icon: "gearshape.fill", selectedIcon: "gearshape.fill", index: 2)
                        }
                        .frame(height: 50)
                        .padding(.horizontal)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        
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
            viewModel.feedbackHapitcs()
        }) {
            Image(systemName: selectedTab == index ? selectedIcon : icon)
                .font(.system(size: 25))
                .foregroundColor(selectedTab == index ? .cyan : .gray)
            
        }
    }
}



#Preview {
    TabBar(angle: .constant(0))
        .environmentObject(ListViewModel())
}
