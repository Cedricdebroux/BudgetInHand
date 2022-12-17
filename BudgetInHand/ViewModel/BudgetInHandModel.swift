//
//  BudgetInHandModel.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 05/12/2022.
//
import Foundation

class BudgetInHandModel: ObservableObject{
    @Published var userId: String?
    @Published var selectedView : Int?
}
