//
//  LoginView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 05/12/2022.
//

import SwiftUI
import FirebaseAuth
import Firebase
import Lottie

class FirebaseManager: NSObject {
    
    let auth: Auth
    
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        
        super.init()
    }
    
}


struct LoginView: View {
    @EnvironmentObject var appModel: BudgetInHandModel

    @State private var isLoginValid = false
    @State private var isLogin = true
    @State var email = "ced.debroux@gmail.com"
    @State var password = "654321"
    @State var password1 = ""
    @State var showSheet : Bool = false
    var isSignInButtonDisabled: Bool {
        [email, password].contains(where: \.isEmpty)
    }

    var body: some View {
        NavigationStack {
            
            VStack(spacing: -50){
                Text("Se connecter")
                    .font(.title2)
                    .foregroundColor(Color("Blue600"))
                LottieView(name: "login", loopMode: .loop)
                Form{
                    Section("Email"){
                        ZStack(alignment: .trailing){
                            TextField("Email", text: $email)
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
                    Section("Mot de passe"){
                        ZStack(alignment: .trailing){
                            SecureField("Password", text: $password)
                            
                            if(!password.isEmpty){
                                Image(systemName: "xmark.circle.fill")
                                    .onTapGesture {
                                        password = ""
                                    }
                            }
                        }
                        .foregroundColor(Color("Blue600"))
                    }
                    
                }
                .scrollContentBackground(.hidden)
                .preferredColorScheme(.light)
                
                VStack(spacing: 30){

                        Button(action: {
                            loginUser()
                        }){
                                Text("Connection")
                                    .frame(maxWidth: 300)
                        }
                        .tint(Color("Blue600"))
                        .buttonStyle(.borderedProminent)
                        .foregroundColor(.white)
                        .controlSize(.large)
                        .disabled(isSignInButtonDisabled)
                    HStack(spacing: 70){
                        NavigationLink(destination: CreateAccountView()){
                            Text("Nouveau compte")
                            
                        }
                        Button("Reset Password"){
                            showSheet.toggle()
                        }.sheet(isPresented: $showSheet){
                            ResetPasswordView(showSheet: $showSheet)
                        }
                    }
                    .font(.system(size: 15))
                    .tint(Color.black)
                }
            }
            .navigationDestination(isPresented: $isLoginValid){
                MainView()
                    .navigationBarBackButtonHidden(true)
            

            }
            .ignoresSafeArea(.keyboard)
            .background(Color(UIColor(named: "Gray300") ?? .white))
        }
    }

    private func loginUser() {
    
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed due to error:", err)
                return
            }
            appModel.userId = result?.user.uid
            if( appModel.userId != nil){
                isLoginValid = true
                print("Successfully logged in with ID: \(result?.user.uid ?? "")")
                
            } else{
                print("This userId doesn't exist\(String(describing: result?.user.uid))")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
