//
//  SplashScreen.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 08/12/2022.
//

import SwiftUI

struct SplashScreen: View {
    @State private var startAnimating = false
    @State private var handanimating = false
    var body: some View {
        ZStack{
            Color("Blue700").ignoresSafeArea()
            
            GeometryReader{ proxy in
                let size = proxy.size
            
                Image("logo")
                
                    .resizable()
                    .renderingMode(.template).aspectRatio(contentMode: .fit)
                    .position(x: 180, y: -200)
                    .offset(x: 0, y: startAnimating ? 730 : 0)
                    .animation(.easeInOut(duration: 2).delay(1))
                    .foregroundColor(.white)
                
                VStack{
                    
                    Image("openHand")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio( contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(alignment: .center)
                        .offset(x:0, y: startAnimating ? 400 : 0)
                        .animation(.easeInOut(duration:  2).delay(1))
 
                }.frame(width: .infinity, height:  .infinity ,alignment: .center)
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() ){
                startAnimating.toggle()
                handanimating.toggle()
            }
            
        }
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
