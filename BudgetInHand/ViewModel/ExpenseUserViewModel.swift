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
        fetchExpenseCurrentUser()
    }
    private func fetchExpenseCurrentUser(){
        guard let uid = Auth.auth().currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        Firestore.firestore().collection("Expenses")
            .document(uid).getDocument { snapshot, error in
                if let error = error {
                    print("Failed to fetch current user:", error)
                    return
                }
                guard let data = snapshot?.data() else { return }
                
                self.errorMessage = "\(data)"
                
                let uid = data["userId"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let date = data["date"] as? Date ?? Date()
                let category = data["category"] as? String ?? ""
                let amount = data["amount"] as? Float ?? 0.0
                
                self.currentExpenseUser = Expense(category: category, date: date, amount: amount, userId: uid)
            }
    }
}
