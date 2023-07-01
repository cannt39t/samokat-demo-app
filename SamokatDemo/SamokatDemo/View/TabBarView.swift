//
//  TabBarView.swift
//  SamokatDemo
//
//  Created by Илья Казначеев on 28.06.2023.
//

import SwiftUI

enum Tabs: Int, CaseIterable {
    case main, search, cart, account
}

struct TabBarView: View {
    
    @EnvironmentObject private var alertManager: DishCartPresentManager
    
    var body: some View {
        ZStack {
            TabView {
                ForEach(Tabs.allCases, id: \.self) { tab in
                    VStack {
                        getView(for: tab)
                    }
                    .tabItem {
                        R.TabBar.getImageFor(tab).renderingMode(.template)
                        Text(R.TabBar.getTitleFor(tab))
                            .font(R.Fonts.SF_Pro_Display(10, .medium))
                    }
                }
            }
            .tint(R.Colors.primary)
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
                appearance.backgroundColor = UIColor(R.Colors.background)
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .opacity(alertManager.isPresent ? 1 : 0)
                .animation(.easeInOut, value: "easeInOut")
            if alertManager.isPresent {
                withAnimation {
                    DishCartView(dish: $alertManager.dish)
                }
            }
        }
    }
    
    private func getView(for tab: Tabs) -> some View {
        switch tab {
            case .main: return AnyView(HomeView())
            case .search: return AnyView(SearchView())
            case .cart: return AnyView(CartView())
            case .account: return AnyView(AccountView())
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
