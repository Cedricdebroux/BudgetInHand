//
//  ContentView.swift
//  BudgetInHand
//
//  Created by Cédric Debroux on 25/11/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject var appModel = BudgetInHandModel()
    
    var body: some View {
        NavigationView{
            SplashScreenView()
            //LoginView()
        }.environmentObject(appModel)
       
       
//        NavigationView {
//            VStack {
//                NavigationLink("New Expense", destination: NewExpenseView()).buttonStyle(PlainButtonStyle())
//
//                NavigationLink("Login", destination: LoginView()).buttonStyle(PlainButtonStyle())
//            }
//        }.environmentObject(appModel)
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
