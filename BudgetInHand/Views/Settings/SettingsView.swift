//
//  SettingsView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 07/12/2022.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack{
            Label("Paramètres du compte", systemImage: "gear")
                .font(.title2)
                .foregroundColor(Color("Blue600"))
            NavigationView{
                List {
                    NavigationLink(destination: Text("Endroits préférés")) {
                        Label("Endroits préférés", systemImage: "mappin.and.ellipse")
                            .foregroundColor(Color("Blue600"))
                    }
                    NavigationLink(destination: Text("Autorisations")) {
                        Label("Autorisations", systemImage: "key.viewfinder")
                            .foregroundColor(Color("Blue600"))
                    }
                    NavigationLink(destination: Text("Durée du budget")) {
                        Label("Durée du budget", systemImage: "timer")
                            .foregroundColor(Color("Blue600"))
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
