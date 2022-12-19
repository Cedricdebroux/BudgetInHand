//
//  ContentView.swift
//  BudgetInHand
//
//  Created by Cédric Debroux on 25/11/2022.
//

import SwiftUI
import Combine


struct ContentView: View {
    @UserDefault(key:"isOnboarded", defaultValue: false)

    //MARK: Variables
    static var isOnboarded: Bool
    @StateObject var appModelOnBoarding = BudgetInHandModel()
    var  isAlreadySwawned = UserDefaults.standard.bool(forKey: "checkOnBoarding")
    @State private var isOnBoardingActive = false
    @State private var isSplashActive = false
    @StateObject var appModel = BudgetInHandModel()
    @State private var isOnBoardingAlreadyAppear = false
    
    
    
    //MARK:Methods
    
//    func checkOnBoarding(){
//        if isAlreadySwawned == true {
//            NavigationLink(destination: LoginView()){
//
//            }
//        } else {
//            addValueForOnBoarding()
//            OnBoarding()
//        }
//    }
//
    func addValueForOnBoarding(){
        UserDefaults.standard.set(isOnBoardingAlreadyAppear, forKey: "checkOnBoarding")
    }
    
    //MARK: Body
    
    var body: some View {
        
        NavigationStack{
        
        VStack{
            
            if self.isSplashActive{
                if Self.isOnboarded {
                    LoginView()
                }else
                {
                    OnBoarding()
                }
                
            } else {
                SplashScreen().transition(.opacity)
            }
        }
            .onAppear{
             
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.8){
                    withAnimation{
                        self.isSplashActive = true
                    }
                }
                }
        }.environmentObject(appModel)
            .environmentObject(appModelOnBoarding)
    }
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
