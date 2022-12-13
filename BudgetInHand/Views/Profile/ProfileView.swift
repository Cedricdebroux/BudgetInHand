//
//  ProfileView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 07/12/2022.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appModel: BudgetInHandModel
    @State private var showAlert = false
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
                            .foregroundColor(Color("Blue600"))
                    }
                    NavigationLink(destination: Text("Budget global")) {
                        Label("Définisez votre budget", systemImage: "eurosign.circle")
                            .foregroundColor(Color("Blue600"))
                    }
                    NavigationLink(destination: Text("Se désinscrire")
                    ) {
                        Label("Changer votre mot de passe", systemImage: "person.badge.key")
                            .foregroundColor(Color("Blue600"))
                    }

                    NavigationLink(destination: Text("relevés de compte")
                    ) {
                        Label("Relevés de compte", systemImage: "list.bullet.rectangle.portrait")
                            .foregroundColor(Color("Blue600"))
                    }
        
                    
                    Button{
                        showAlert = true} label: {
                            Label("Se désinscrire", systemImage: "wrongwaysign")
                                .foregroundColor(Color.red)
                        }
                    
                }
                .alert("Attention, la suppression de votre compte sera définitive. Êtes vous certain de vouloir supprimer votre compte ?",isPresented: $showAlert){
                        Button("Oui", role: .cancel){
                            
                        }
                        Button("Non", role: .none){
                            
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
