//
//  Category.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 06/12/2022.
//

import Foundation

enum Category: String,CaseIterable, Identifiable {
    
    
    
    case carburant, energie, nourriture, home
    
    var id: Self { self }
    
}


