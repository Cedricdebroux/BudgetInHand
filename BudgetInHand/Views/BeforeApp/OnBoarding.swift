//
//  OnBoarding.swift
//  BudgetInHand
//
//  Created by Germain Buchet on 12/12/2022.
//

import SwiftUI
import Lottie
import Combine
struct OnBoarding: View {
    @EnvironmentObject var appModel: BudgetInHandModel
    @State private var showFirstTimeOnboarding = true
    @State var isOnBoardingAlreadyAppear = false
    
    
    var body: some View {
        TabView{
            //NavigationView{
            VStack{
                Text("Bienvenue dans l'application BudgetInHand")
                    .font(.title)
                    .bold()
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .navigationBarBackButtonHidden(true)
                LottieView(name: "financialplan", loopMode: .loop)
                Text("L'application qui vous facilite l'encodage et la gestion de vos dépenses")
                    .multilineTextAlignment(.center)
                Spacer(minLength: 70)
            }
            VStack{
                
                Text("Sélection d'une dépense grâce à l'appareil photo")
                    .font(.title2)
                    .bold()
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                LottieView(name: "scanpicturetransparancy", loopMode: .loop)
                Text("BudgetInHand vous permet d'utiliser la sélection d'une valeur grâce à la caméra de votre Iphone")
                    .multilineTextAlignment(.center)
                Spacer(minLength: 70)
            }
            .navigationBarBackButtonHidden(true)
            
            VStack{
                Spacer()
                Text("Gestion simplifiée")
                    .font(.title2)
                    .bold()
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                
                LottieView(name: "planbudget", loopMode: .loop)
                Text("Rendez vous dans les paramètres de votre compte et définissez vous un budget mensuel pour chaque catégorie de dépenses")
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .multilineTextAlignment(.center)

                Spacer(minLength: 70)
            }
            .navigationBarBackButtonHidden(true)
        }.onAppear{
            DispatchQueue.main.async {
                var isAlreadyAppear: Bool = UserDefaults.standard.bool(forKey: "onBoardingisAlreadyAppear")
                
                if isAlreadyAppear == true {
                    
                }else {
                    UserDefaults.standard.set(isOnBoardingAlreadyAppear, forKey: "onBoardingisAlreadyAppear")
                    appModel.isOnBoardingAlreadyAppear = true
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .background(Color("Gray300"))
        .foregroundColor(Color("Blue600"))
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink(destination: LoginView()){
                    Text("Skip").foregroundColor(Color("Blue600"))
                }
            }
        }
    }
    
    //MARK: methods
    
    private func checkOnboarding(){
        if showFirstTimeOnboarding == true{
            
            showFirstTimeOnboarding = false
            UserDefaults.standard.set(self.showFirstTimeOnboarding, forKey: "isShowOnboarding")
        }
    }
    
}






struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}

