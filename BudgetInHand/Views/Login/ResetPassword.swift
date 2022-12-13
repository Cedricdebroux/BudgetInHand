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
    @Binding var showSheet : Bool
    @State var email = ""
    @State var  showLogin : Bool = false
    @State var showalert = false
    
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
                        showalert = true
                        resetPassword()
                    } label: {
                        Text("Reset Password")
                            .frame(maxWidth: .infinity)
                            .font(.title2)
                    }.alert("Si votre mail existe dans notre base de données.Un mail vous a été envoyé pour créer un nouveau mot de passe", isPresented: $showalert){
                        Button("ok", role: .cancel){
                            
                        }
                        Button("Non", role: .none){
                            
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("Blue600"))
                    .cornerRadius(16)
                    
                }.padding(25)
            }
                Spacer()
                
                NavigationLink(destination: LoginView()){
                    Button("Back to login"){
                        showSheet.toggle()
                    }
                }
              
            }
            .navigationTitle("Reset Password")
        }
    }
}


//struct ResetPasswordView_Previews: PreviewProvider {
//    
//    @State var showSheet: Bool = false
//    static var previews: some View {
//        
//        ResetPasswordView(showSheet: Binding(true))
//    }
//}
