//
//  SplashScreenView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 08/12/2022.
//

import SwiftUI

struct SplashScreenView: View {
    
    //animations proprerties
    @State var startAnimation = false
    @State var bowAnimation = false
    @State var glow = false
    @State var showHand = false
    @State var handGlow = false
    @State var isFinished = false
    
    var body: some View {
        ZStack{
            Color(UIColor(named: "Blue700") ?? .gray)
                .ignoresSafeArea()
            
            //Logo
            GeometryReader{proxy in
                    
                //screen size
                let size = proxy.size
                
                ZStack{
                    //rainbow
                    Circle()
                        .trim(from: 0, to: bowAnimation ?  0.5 : 0)
                    .stroke( //Set gradient
                        .linearGradient(.init(colors: [
                        
                            Color("Blue100"),
                            Color("Blue300"),
                            Color("Blue500"),
                            Color("Blue700"),
                            Color("Blue800"),
                            Color("Blue900"),
                        
                        ]), startPoint: .leading, endPoint: .trailing)
                        ,style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round)
                    )
                    .overlay(content: {
                        Circle()
                            .fill(Color.white.opacity(0.4))
                            .frame(width: 6, height: 6)
                            .overlay(
                                Circle()
                                    .fill(Color.white.opacity(glow ? 0.2 : 0.1))
                                    .frame(width: 6, height: 6)
                            )
                            .blur(radius: 2.5)
                        //Move toward lefet
                            .offset(x: (size.width / 2) / 2)
                        // Move towards bow
                            .rotationEffect(.init(degrees: bowAnimation ? 180 : 0))
                            .opacity(startAnimation ? 1 : 0)
                    })
                    .frame(width: size.width / 2, height: size.width / 2)
                    .rotationEffect(.init(degrees: -200))
                    .offset(y: 10)
                       
                   
                    HStack(spacing: -60){
                        Image("logo")
                            
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: size.width / 1.5, height: size.width / 1.5)
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .opacity(bowAnimation ? 1 : 0)
                        
                        Image("hand")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .opacity(bowAnimation ? 1 : 0)
                            .background(
                                ZStack{
                                    Circle()
                                        .fill(Color.white.opacity(0.25))
                                        .frame(width: 20, height: 20)
                                        .blur(radius: 2)
                                    
                                    Circle()
                                        .fill(Color.white.opacity(0.2))
                                        .frame(width: 35, height: 35)
                                        .blur(radius: 2)
                                    
                                    
                                }
                                    .opacity(handGlow ? 1 : 0)
                            )
                            .scaleEffect(showHand ? 1 : 0)
                        
                        
                        
                    }
                        
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity,
                       alignment: .center)
            }
        }.onAppear{
            //set a delay 0.3s
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                withAnimation(.linear(duration: 2)){
                    bowAnimation.toggle()
                }
                
                // Glow animation
                
                withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)){
                    glow.toggle()
                }
                
                //We dont need grow from bottom of logo so delaying animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    withAnimation(.spring()){
                        startAnimation.toggle()
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                    withAnimation(.spring()){
                        showHand.toggle()
                        startAnimation.toggle()
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7){
                    withAnimation(.linear(duration: 0.5)){
                        handGlow.toggle()
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    withAnimation(.linear(duration: 0.4)){
                        handGlow.toggle()
                    }
                }
            }
            }
        }
    }


struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
