//
//  DetailExpenses.swift
//  BudgetInHand
//
//  Created by Germain Buchet on 08/12/2022.
//

import SwiftUI

struct DetailExpenses: View {
    @StateObject private var showDetail = BudgetInHandModel()
    var angleSpace: Angle = Angle(degrees: 0)
    var isClickable: Bool = false
    var valuesPie : [Double] = [300]
    var namePie : [String] = ["Carburant"]
    var colorChart: [Color] = [Color.fromInts(r: 0, g: 181, b: 216)]
    var numberTotalExpenses : Int = 10
    let imageArray = ["car.fill"]
    
    var body: some View {
        VStack{
            VStack{
                PieChartView(
                    isClickable : isClickable,
                    values: valuesPie ,
                    names: namePie,
                    formatter: { $0.description },
                    colors: colorChart,
                    iconNames: imageArray,
                    backgroundColor: Color.fromInts(r: 250,
                                                    g: 250,
                                                    b: 250),
                    angleSpace: Angle(degrees: 0))
                Spacer()
                    .frame(height: 60)
                NavigationStack{
                    List {
                        Section(header: Text("Liste des dernières dépenses")){
                            ForEach(0..<10) { _ in
                                Text("Integer")
                            }
                        }
                    }
                }
            }
        }
    }
    struct DetailExpenses_Previews: PreviewProvider {
        static var previews: some View {
            DetailExpenses()
        }
    }
}