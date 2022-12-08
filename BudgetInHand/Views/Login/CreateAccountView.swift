//
//  CreateAccountView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 08/12/2022.
//

import SwiftUI
import FirebaseAuth

struct CreateAccountView: View {
    
    @EnvironmentObject var appModel: BudgetInHandModel
    
    @State var email = ""
    @State var name = ""
    @State var passwordOne = ""
    @State var passwordTwo = ""
    var body: some View {
        NavigationStack{
            ZStack{
                Color("Gray300")
                    .ignoresSafeArea()
                VStack{
                    Text("Création d'un nouveau compte")
                        .font(.title2)
                    Image("Memoji")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180)
                        .clipShape(Circle())
                    Form(){
                        Section{
                            ZStack(alignment: .trailing){
                                TextField("Entrez votre mail", text: $email)
                                    .keyboardType(.emailAddress)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                if(!email.isEmpty){
                                    Image(systemName: "xmark.circle.fill")
                                        .onTapGesture {
                                            email = ""
                                        }
                                }
                            }
                        }
                        Section{
                            ZStack(alignment: .trailing){
                                TextField("Entrez votre Nom", text: $name)
                                    .keyboardType(.emailAddress)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                if(!name.isEmpty){
                                    Image(systemName: "xmark.circle.fill")
                                        .onTapGesture {
                                            name = ""
                                        }
                                }
                            }
                        }
                        Section{
                            ZStack(alignment: .trailing){
                                SecureField("Entrez votre mot de passe", text: $passwordOne)
                                    .keyboardType(.emailAddress)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                if(!passwordOne.isEmpty){
                                    Image(systemName: "xmark.circle.fill")
                                        .onTapGesture {
                                            passwordOne = ""
                                        }
                                }
                            }
                        }
                        Section{
                            ZStack(alignment: .trailing){
                                SecureField("Confirmer votre mot de passe", text: $passwordTwo)
                                    .keyboardType(.emailAddress)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                if(!passwordTwo.isEmpty){
                                    Image(systemName: "xmark.circle.fill")
                                        .onTapGesture {
                                            passwordTwo = ""
                                        }
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .foregroundColor(Color( "FonttextField"))
                    
                    Button(action: {
                        createUser()
                    }){
                        Text("Créer votre compte")
                            .frame(maxWidth: 300)
                    }
                    .tint(Color(UIColor(named: "Gray800") ?? .blue))
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(.white)
                    .controlSize(.large)
                }
            }
        }
    }
    private func createUser() {
        Auth.auth().createUser(withEmail: email, password: passwordOne, completion: { result, err in
            if let err = err {
                print("Failed due to error:", err)
                return
            }
            print("Successfully created account with ID: \(result?.user.uid ?? "")")
            appModel.userId = result?.user.uid
            
        })
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
