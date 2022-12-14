//
//  ExpenseUserViewModel.swift
//  BudgetInHand
//
//  Created by Cédric Debroux on 14/12/2022.
//

import Foundation
import Firebase

class ExpenseUserViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var currentExpenseUser: Expense?
    init() {
        
    }
    private func fetchExpenseCurrentUser(){
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
                
//                self.currentExpenseUser = Expense(userId: uid,title: <#T##String?#>, category: <#T##String?#> )
            }
    }
    
//    func fetchData(userId: String) {
//        databaseReference.whereField("userId" , isEqualTo: userId).addSnapshotListener { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//
//            self.expenses = documents.compactMap { queryDocumentSnapshot -> Expense? in
//                return try? queryDocumentSnapshot.data(as: Expense.self)
//            }
//        }
//    }
}
