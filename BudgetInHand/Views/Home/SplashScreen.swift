//
//  SplashScreen.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 08/12/2022.
//

import SwiftUI

struct SplashScreen: View {
    @State private var startAnimating = false
    var body: some View {
        ZStack{
            Color("Blue700").ignoresSafeArea()

            
            GeometryReader{ proxy in
                let size = proxy.size
                
                VStack{
                    
                    
                    
                        Image("logo")
                        
                            .resizable()
                            .renderingMode(.template).aspectRatio(contentMode: .fit)
                            .position(x: 180, y: -200)
                            .offset(x: 0, y: startAnimating ? 720 : 0)
                            .animation(.easeInOut(duration: 2.5).delay(1))
                            .foregroundColor(.white)
                        
                        Image("openHand")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio( contentMode: .fit)
                            .foregroundColor(.white)
                        
                    
                }.frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .center)
            }
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                startAnimating.toggle()
            }
        }
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
