//
//  SplashScreen.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 08/12/2022.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack{
            Color("Blue700").ignoresSafeArea()

            
            GeometryReader{ proxy in
                let size = proxy.size
                
                ZStack{
                    
                    
                    
                        Image("logo")
                            .resizable()
                            .renderingMode(.template).aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                        
                        Image("2hand")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                        
                    
                }.frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .center)
            }
        }
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
