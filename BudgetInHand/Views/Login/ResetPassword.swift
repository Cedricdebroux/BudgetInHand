//
//  ResetPassword.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 12/12/2022.
//

import SwiftUI
import FirebaseAuth
struct ResetPasswordView: View {
    
    @Environment(\.presentationMode) var presentation
    @State var showAlert = false
    @State var email = ""
    @State var  showLogin : Bool = false
    
    private func resetPassword(){
        Auth.auth().sendPasswordReset(withEmail: email){ error in
            if let err = error {
                print("Error : \(err.localizedDescription)")
            }
            print("😒 Reset password")
            
            //Bring user back to login
            presentation.wrappedValue.dismiss()
        }
    }
    
    
    
    var body: some View {
        
        NavigationStack{
            VStack{
                
                
                
                
                VStack(spacing: 20){
                    TextField("Email",text: $email, prompt: Text("Enter email..."))
                        .font(.title2)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                    
                }.padding()
                    .padding(.bottom, 8)
                NavigationLink(destination: LoginView()){
                VStack(spacing: 16){
                    
                    Button{
                        resetPassword()
                    } label: {
                        Text("Reset Password")
                            .frame(maxWidth: .infinity)
                            .font(.title2)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("Green800"))
                    .cornerRadius(16)
                    
                }.padding(25)
            }
                Spacer()
                
                
                Button{
                    
                } label: {
                    Text("Back to login")
                        .frame(maxWidth: .infinity)
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            .navigationTitle("Reset Password")
        }
    }
}


struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
