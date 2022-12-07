//
//  LoginView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 05/12/2022.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @EnvironmentObject var appModel: BudgetInHandModel
    
    @State private var isLogin = true
    @State var email = "qb@bih.com"
    @State var password = "123456"
    @State var password1 = ""
    
    //test
    
    
    var body: some View {
        NavigationView {
                  VStack(spacing: 16) {
                      Picker("", selection: $isLogin) {
                          Text("Log In")
                              .tag(true)
                          Text("Create Account")
                              .tag(false)
                      }.pickerStyle(SegmentedPickerStyle())
                      .padding()
                      
                   
                      TextField("Email", text: $email)
                          .keyboardType(.emailAddress)
                          .disableAutocorrection(true)
                          .autocapitalization(.none)
                          .textFieldStyle(.roundedBorder)
                          .frame(width: 280, height: 45, alignment: .center)
                      SecureField("Password", text: $password)
                          .textFieldStyle(.roundedBorder)
                          .frame(width: 280, height: 45, alignment: .center)
                      Spacer()
                      Button(action: {
                          
                          if isLogin {
                              loginUser()
                          } else {
                              createUser()
                          }
                         // TODO
                      }, label: {
                          Text(isLogin ? "Log In" : "Create Account")
                          .foregroundColor(.white)
                      }).frame(width: 280, height: 45, alignment: .center)
                          .background(Color.blue)
                          .cornerRadius(8)
                  }.navigationTitle(isLogin ? "Welcome Back" : "Welcome")
              }
    }
    private func loginUser() {
           Auth.auth().signIn(withEmail: email, password: password) { result, err in
               if let err = err {
                   print("Failed due to error:", err)
                   return
                   //TODO navigation to home
               }
               appModel.userId = result?.user.uid
               
               if( appModel.userId != nil){
                   print("Successfully logged in with ID: \(result?.user.uid ?? "")")
               } else{
                   print("This userId doesn't exist\(result?.user.uid)")
               }
               
               
               
           }
       }
       
    private func createUser() {
           Auth.auth().createUser(withEmail: email, password: password, completion: { result, err in
               if let err = err {
                   print("Failed due to error:", err)
                   return
               }
               print("Successfully created account with ID: \(result?.user.uid ?? "")")
               appModel.userId = result?.user.uid
               
           })
       }
   
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
