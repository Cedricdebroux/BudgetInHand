//
//  UserViewModel.swift
//  BudgetInHand
//
//  Created by Cédric Debroux on 14/12/2022.
//

import Foundation
import SwiftUI
import Firebase

class UserViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var currentUser: User?
    init() {
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        Firestore.firestore().collection("users")
            .document(uid).getDocument { snapshot, error in
                if let error = error {
                    print("Failed to fetch current user:", error)
                    return
                }
                guard let data = snapshot?.data() else { return }
                
                self.errorMessage = "\(data)"
                
                let uid = data["uid"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let name = data["userName"] as? String ?? ""
                let profileImageUrl = data["profileImageUrl"] as? String ?? ""
                
                self.currentUser = User(uid: uid, email: email, name: name, profileImageUrl: profileImageUrl)
            }
    }
}
