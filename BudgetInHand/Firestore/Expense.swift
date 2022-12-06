//
//  Expense.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 05/12/2022.
//

import FirebaseFirestoreSwift
import SwiftUI

struct Expense: Codable {
    @DocumentID var id: String? // @DocumentID to fetch the identifier from Firestore
    var title: String?
    var category: String?
    var date: String?
    var amount: String?
    var userId: String?
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case category
        case date
        case amount
        case userId
    }
}

enum Categorie: Codable {
    
    case carburant
    case energie
    case nourriture
    case home
    
}
