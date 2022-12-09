//
//  ContentView.swift
//  BudgetInHand
//
//  Created by Cédric Debroux on 25/11/2022.
//

import SwiftUI
import CoreData


struct ContentView: View {
    
    @State private var isSplashActive = false
    @StateObject var appModel = BudgetInHandModel()
    
    var body: some View {
        
        VStack{
            
            if self.isSplashActive{
                LoginView()
                
            } else {
                SplashScreen().transition(.opacity)
            }
            
        }.environmentObject(appModel)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.8){
                    withAnimation{
                        self.isSplashActive = true
                    }
                }
            }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
