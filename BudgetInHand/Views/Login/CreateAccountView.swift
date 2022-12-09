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
    
    @State private var showAlert = false
    @State private var email = ""
    @State private var name = ""
    @State private var passwordOne = ""
    @State private var passwordTwo = ""
    var isSignUpButtonDisabled: Bool {
        [email, passwordOne, passwordTwo, name].contains(where: \.isEmpty)  
    }
    var body: some View {
        NavigationStack{
            ZStack{
                Color("Gray300")
                    .ignoresSafeArea()
                VStack{
                    Text("Création d'un nouveau compte")
                        .font(.title2)
                        .foregroundColor(Color("Blue600"))
                    Image("Memoji")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180)
                        .clipShape(Circle())
                    Form(){
                        Section("Email"){
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
                            .foregroundColor(Color("Blue600"))
                        }
                        .foregroundColor(Color( "Gray600"))
                        Section("Nom"){
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
                            .foregroundColor(Color("Blue600"))
                        }
                        .foregroundColor(Color( "Gray600"))
                        Section("Mot de passe"){
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
                            .foregroundColor(Color("Blue600"))
                        }
                        .foregroundColor(Color( "Gray600"))
                        Section("Répétez votre mot de passe"){
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
                            .foregroundColor(Color("Blue600"))
                        }
                        .foregroundColor(Color( "Gray600"))
                    }
                    .scrollContentBackground(.hidden)
                    
                    Button(action: {
                        if (passwordOne != passwordTwo) {
                            showAlert = true
                        } else {
                            createUser()
                        }
                    }){
                        Text("Créer votre compte")
                            .frame(maxWidth: 300)
                    }
                    .tint(Color("Blue600"))
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(.white)
                    .controlSize(.large)
                    .disabled(isSignUpButtonDisabled)
                    .alert(isPresented: $showAlert){
                        Alert(title: Text("Attention !"), message: Text("Vos mots de passe ne correspondes pas"))
                    }
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
