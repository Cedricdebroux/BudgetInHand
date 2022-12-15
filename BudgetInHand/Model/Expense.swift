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
    var category: String?
    var date: Date?
    var amount: Float?
    var image: String?
    var userId: String?
    
    
    enum CodingKeys: CodingKey {
        case id
        case category
        case date
        case amount
        case image
        case userId
    }
}





