//
//  HomeView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 07/12/2022.
//

import SwiftUI

struct HomeView: View {
    var valuesPie : [Double] = [300,400,600,500]
    var namePie : [String] = ["Carburant","Energie","Comissions","Charges"]
    var colorChart: [Color] = [Color.fromInts(r: 0, g: 181, b: 216), Color.fromInts(r: 0, g: 119, b: 182),Color.fromInts(r: 144, g: 224, b: 238),Color.fromInts(r: 3, g: 4, b: 94)]
    let imageArray = ["car.fill","bolt.fill","cart.fill","house.fill"]
    //let imageView = UIImageView(image: image)
    
    var body: some View {
     
            VStack{
                
                VStack{
                    PieChartView(
                        values: valuesPie,
                        names: namePie,
                        formatter: { $0.description },
                        colors: colorChart,
                        iconNames: imageArray,
                        backgroundColor: Color.fromInts(r: 250,
                                                        g: 250,
                                                        b: 250))
                }
                Spacer()
                    .frame(height: 230)
                
                NavigationStack{
                    List {
                        ForEach(0..<3) { _ in
                            Text("Integer")
                        }
                    }
                }
                
            }
        }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
