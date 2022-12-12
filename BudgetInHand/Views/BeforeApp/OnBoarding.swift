//
//  OnBoarding.swift
//  BudgetInHand
//
//  Created by Germain Buchet on 12/12/2022.
//

import SwiftUI

struct OnBoarding: View {
    
    //@State var shouldShowOnboarding: Bool = true
    
    var body: some View {
        TabView{
            
            VStack(){
                Text("Bienvenue dans l'application BudgetInHand")
                    .font(.title)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                Image("onboarding1")
                    .resizable()
                        .frame(width: 400.0, height: 600.0)
            }
                
//                Text("Voici quelques informations que vous pourrez retrouver dans les différents écrans de l'application ainsi que la manière d'ajouter facilement une nouvelle dépense dans une catégorie !")
//            }.multilineTextAlignment(.center)
            
            VStack(){
                Text("Pour ajouter automatiquement une nouvelle dépense, il vous suffit de prendre une photo de votre ticket de caisse !")
                    .font(.title)
                    .multilineTextAlignment(.center)
                Image("onboarding2")
            }
            VStack{
                NavigationLink(destination: LoginView()){
                    
                        Text("Close")
                    
                }
                
                    
            }
            
            
                
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}
