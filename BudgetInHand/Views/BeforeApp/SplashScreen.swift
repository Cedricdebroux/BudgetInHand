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
                    .offset(x: 0, y: startAnimating ? 625 : 0)
                    .foregroundColor(.white)
                
                VStack{
                    
                    Image("openHand")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio( contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(alignment: .center)
                        .offset(x:0, y: startAnimating ? 280 : 0)
                }
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation(.easeInOut(duration: 1.5).delay(1)){
                    startAnimating.toggle()
                    handanimating.toggle()
                }
            }
            
        }
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
