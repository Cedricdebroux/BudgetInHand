//
//  UserDefault.swift
//  BudgetInHand
//
//  Created by Cédric Debroux on 19/12/2022.
//

import Foundation
@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
