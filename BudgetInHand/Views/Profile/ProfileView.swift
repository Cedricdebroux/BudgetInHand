//
//  ProfileView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 07/12/2022.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                Button {
                    print("Edit button was tapped")
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
                    NavigationLink(destination: Text("Paramètre du compte"), label: {
                        
                    })
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
