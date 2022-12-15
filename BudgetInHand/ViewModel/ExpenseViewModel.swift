//
//  ExpenseViewModel.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 05/12/2022.
//


import FirebaseFirestore
import SwiftUI
import FirebaseAuth
import FirebaseStorage

class ExpenseViewModel: ObservableObject {
    
    
    @Published var expenses = [Expense]() // Reference to our Model
    private var databaseReference = Firestore.firestore().collection("Expenses") // reference to our Firestore's collection

    // function to post data
    func addData(userId: String,category: String,amount: Float, date: Date, image: String ) {
        do {
            _ = try databaseReference.addDocument(data: ["userId": userId , "category": category, "amount": amount, "date": date,"image": image])
        }
        catch {
            print(error.localizedDescription)
        }
        
        
        
        
    }
    
    
    
    // function to read data
    func fetchData(userId: String) {
        databaseReference.whereField("userId" , isEqualTo: userId).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.expenses = documents.compactMap { queryDocumentSnapshot -> Expense? in
                return try? queryDocumentSnapshot.data(as: Expense.self)
            }
        }
    }
    
    // function to update data
    func updateData(id: String, amount: Float, category: String,date: Date, image: String) {
        databaseReference.document(id).updateData(["category" : category]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Expense updated succesfully")
            }
        }
    }
    
    // function to delete data
    func deleteData(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let expense = expenses[index]
            databaseReference.document(expense.id ?? "").delete { error in
                if let error = error {
                    print("\(error.localizedDescription)")
                } else {
                    print("Expense with ID \(expense.id ?? "") deleted")
                }
            }
        }
    }
    
}

