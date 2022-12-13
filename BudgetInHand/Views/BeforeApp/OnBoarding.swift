//
//  OnBoarding.swift
//  BudgetInHand
//
//  Created by Germain Buchet on 12/12/2022.
//

import SwiftUI
import Lottie

struct OnBoarding: View {
    @State private var showFistTimeOnboarding = true
    
    var body: some View {
        TabView{
            //NavigationView{
            VStack{
                Text("Bienvenue dans l'application BudgetInHand")
                    .font(.title)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: LoginView()){
                                Text("Skip")
                            }
                        }
                    }
                
                    .navigationBarBackButtonHidden(true)
                LottieView(name: "financialplan", loopMode: .loop)
                Text("Cette application vous permmet de gérer et encoder facilement vos dépense")
                    .multilineTextAlignment(.center)
                Spacer(minLength: 70)
            }
            
            VStack{
                
                Text("Pour ajouter automatiquement vos dépense, vous pouvez utlisiser l'apparaeil photo")
                    .font(.title3)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                LottieView(name: "scanpicturetransparancy", loopMode: .loop)
                Text("Cette application vous permmet de gérer et encoder facilement vos dépense")
                    .multilineTextAlignment(.center)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: LoginView()){
                                Text("Skip")
                            }
                            
                        }
                        
                    }
                Spacer(minLength: 70)
            }
            .navigationBarBackButtonHidden(true)
            
            VStack{
                Spacer()
                Text("Encodage simplifié")
                    .font(.title)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                
                LottieView(name: "planbudget", loopMode: .loop)
                Text("Vous pouvez ajouter un budget pour vos dépense en carburant, énergie et vos commission via l'écran des paramètres !")
                    .font(.title3)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .multilineTextAlignment(.center)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: LoginView()){
                                Text("Skip")
                            }
                            
                        }
                        
                    }
                Spacer(minLength: 70)
            }
            .navigationBarBackButtonHidden(true)
        }
        // }
        
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .background(Color("Gray300"))
        .foregroundColor(Color("Blue600"))
    }
    
    private func checkOnboarding(){
        if showFistTimeOnboarding == true{
            
            showFistTimeOnboarding = false
            UserDefaults.standard.set(self.showFistTimeOnboarding, forKey: "isShowOnboarding")
            OnBoarding()
        }
    }
    
}






struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}

