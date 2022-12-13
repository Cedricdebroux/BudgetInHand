//
//  MainView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 12/12/2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
            TabView{
                
                    
                    HomeView()
                        .tabItem{
                            Label("Home",systemImage: "house")
                        }.toolbar(.visible, for: .tabBar)
                    ProfileView()
                        .tabItem{
                            Label("Profile", systemImage: "person")
                        }.toolbar(.visible, for: .tabBar)
                    InitialNewExpenseview()
                        .tabItem{
                            Label("Add expense", systemImage: "plus.circle")
                        }.toolbar(.visible, for: .tabBar)
            }
        }
    }

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
