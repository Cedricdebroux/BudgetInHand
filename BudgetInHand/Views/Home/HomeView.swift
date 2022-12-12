//
//  HomeView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 07/12/2022.
//

import SwiftUI

struct HomeView: View {
    
    var isClickable = true
    var valuesPie : [Double] = [300,400,600,500]
    var namePie : [String] = ["Carburant","Energie","Comissions","Charges"]
    var colorChart: [Color] = [Color.fromInts(r: 0, g: 181, b: 216), Color.fromInts(r: 0, g: 119, b: 182),Color.fromInts(r: 144, g: 224, b: 238),Color.fromInts(r: 3, g: 4, b: 94)]
    let imageArray = ["car.fill","bolt.fill","cart.fill","house.fill"]
    var angleSpace: [Angle] = [Angle(degrees: 3)]
    
 
    
    
    var body: some View {
        
        NavigationView{
            VStack{
                VStack{
                    PieChartView(
                        isClickable: isClickable,
                        values: valuesPie,
                        names: namePie,
                        formatter: { $0.description },
                        colors: colorChart,
                        iconNames: imageArray,
                        backgroundColor: Color.fromInts(r: 250,
                                                        g: 250,
                                                        b: 250), angleSpace: Angle(degrees: 3))
                }
                Spacer()
                    .frame(height: 230)
                List {
                    ForEach(0..<3) { _ in
                        Text("Integer")
                    }
                }
            }.navigationBarBackButtonHidden(true)
        }
//        .fullScreenCover(isPresented: $shouldShowOnboarding, content: {
//
//        })
    }
        
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
