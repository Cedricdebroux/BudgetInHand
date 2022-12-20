//
//  CreateAccountView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 08/12/2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import Firebase

struct CreateAccountView: View {
    
    @EnvironmentObject var appModel: BudgetInHandModel
    
    @State private var showAlert = false
    @State private var email = ""
    @State private var name = ""
    @State private var passwordOne = ""
    @State private var passwordTwo = ""
    @State private var shouldShowImagePicker = false
    @State private var image: UIImage?
    @State private var loginStatusMessage = ""
    @State private var isAccountCreate = false
    @State private var isAccountCreateError = false
    
    var isSignUpButtonDisabled: Bool {
        [email, passwordOne, passwordTwo, name].contains(where: \.isEmpty)
    }
    var body: some View {
        NavigationView{
            ZStack{
                Color("Gray300")
                    .ignoresSafeArea()
                VStack{
                    Text("Création d'un nouveau compte")
                        .font(.title2)
                        .foregroundColor(Color("Blue600"))
                    Spacer()
                    Button {
                        shouldShowImagePicker
                            .toggle()
                    } label: {
                        VStack{
                            if let image = self.image{
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 128, height: 128)
                                    .cornerRadius(64)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 90))
                                    .padding()
                                    .foregroundColor(Color("Blue600"))
                            }
                        }
                        .overlay(RoundedRectangle(cornerRadius: 64)
                            .stroke(Color.black, lineWidth: 1))
                    }
                    
                    Form(){
                        Section("Email"){
                            ZStack(alignment: .trailing){
                                TextField("Entrez votre mail", text: $email)
                                    .keyboardType(.emailAddress)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .textContentType(.emailAddress)
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
                                    .textContentType(.name)
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
                                    .textContentType(.newPassword)
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
                                SecureField("Confirmez votre mot de passe", text: $passwordTwo)
                                    .keyboardType(.emailAddress)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .textContentType(.password)
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
                        Alert(title: Text("Attention !"), message: Text("Vos mots de passe ne correspondent pas"))
                    }
                    .alert("Votre compte a bien été créé",isPresented: $isAccountCreate){
                        Button("Ok", role: .cancel){
                        }
                    }
                    .alert("Un erreur s'est produite veuillez réessayer",isPresented: $isAccountCreateError){
                        Button("Ok", role: .cancel){
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isAccountCreate) {
                LoginView()
            }.ignoresSafeArea(.keyboard)
            }
            .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil){
                ImagePicker(image: $image)
            }
    }
    private func createUser() {
        Auth.auth().createUser(withEmail: email, password: passwordOne, completion: { result, err in
            if let err = err {
                print("Failed due to error:", err)
                isAccountCreateError.toggle()
                return
            }
            print("Successfully created account with ID: \(result?.user.uid ?? "")")
            appModel.userId = result?.user.uid
            isAccountCreate.toggle()
            self.persistImageToStorage()
            
        })
    }
    private func persistImageToStorage(){
        let fileName = UUID().uuidString
        guard let uid = Auth.auth().currentUser?.uid
        else { return }
        let ref = Storage.storage().reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5)
        else { return }
        ref.putData(imageData,metadata: nil) { metadata, err in
            if let err = err {
                self.loginStatusMessage = "Failed to push image to Storage : \(err)"
                return
            }
            ref.downloadURL{url, err in
                if let err = err {
                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
                    return
                }
                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                print(url?.absoluteString)
                guard let url = url else { return }
                self.storeUserInformation(imageProfileUrl: url)
            }
        }
    }
    private func storeUserInformation(imageProfileUrl: URL) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["uid": uid, "email" : self.email, "userName" :self.name,"profileImageUrl" : imageProfileUrl.absoluteString]
        Firestore.firestore().collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    self.loginStatusMessage = "\(err)"
                    return
                }
            }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}

