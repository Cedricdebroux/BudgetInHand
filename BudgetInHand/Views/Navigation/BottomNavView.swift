//
//  bottomNavView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 08/12/2022.
//

import SwiftUI

struct BottomNavView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem{
                    Label("Home",systemImage: "house")
                }
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage: "person")
                }
            InitialNewExpenseview()
                .tabItem{
                    Label("Add expense", systemImage: "plus.circle")
                }
           
        }
    }
}

struct bottomNavView_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavView()
    }
}
