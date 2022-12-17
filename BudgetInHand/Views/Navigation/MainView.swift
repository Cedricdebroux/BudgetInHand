//
//  MainView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 12/12/2022.
//

import SwiftUI

struct MainView: View {
    
   
    var body: some View {
        
        TabView(){
            HomeView().tag(1)
                    .tabItem{
                        Image(systemName: "house")
                        Text("Accueil")
                    }.tag(1)
            ProfileView().tag(2)
                    .tabItem{
                        Image(systemName: "person")
                        Text("Profil")
                    }.tag(2)
            NewExpenseView().tag(3)
                    .tabItem{
                        Image(systemName: "plus.circle")
                        Text("Nouvelle Dépense")
                    }.tag(3)
            }.navigationBarBackButtonHidden(true)
            .foregroundColor(Color("Blue800"))
            .toolbar(.automatic)
            .unredacted()
            
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
