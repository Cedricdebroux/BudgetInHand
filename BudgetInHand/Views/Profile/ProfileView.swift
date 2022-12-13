//
//  ProfileView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 07/12/2022.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appModel: BudgetInHandModel
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                NavigationLink {
                    Text("New image")
                    
                } label: {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                HStack{
                    Text("Prénom")
                    Text("Nom")
                }
                List {
                    
                    NavigationLink(destination: Text("Paramètres du compte")) {
                        Label("Paramètres du compte", systemImage: "gear")
                    }
                    NavigationLink(destination: Text("Changer le mot de passe")) {
                        Text("Changer le mot de passe")
                    }
                    NavigationLink(destination: Text("Relevés de compte")) {
                        Text("Relevés de compte")
                    }
        
                    
                    NavigationLink(destination: Text("Se désinscrire")
                    ) {
                        Label("Se désinscrire", systemImage: "wrongwaysign")
                            .foregroundColor(Color.red)
                    }
                }
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
