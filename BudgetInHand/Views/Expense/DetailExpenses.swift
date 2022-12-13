//
//  DetailExpenses.swift
//  BudgetInHand
//
//  Created by Germain Buchet on 08/12/2022.
//

import SwiftUI

struct DetailExpenses: View {
    @StateObject private var showDetail = BudgetInHandModel()
    private var angleSpace: Angle = Angle(degrees: 0)
    private var isClickable: Bool = false
    let valuesPie : [Double]
    let namePie : [String]
    let colorChart: [Color]
    private var numberTotalExpenses : Int = 10
    let imageArray: [String]
    
    init(value: Double, name: String, image: String, colors: Color) {
        valuesPie = [value]
        namePie = [name]
        imageArray = [image]
        colorChart = [colors]
    }
    
    var body: some View {
        HStack{
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
                    .frame(height: 100)
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
            DetailExpenses(value: 300, name: "test", image: "cars", colors: Color.fromInts(r: 0, g: 181, b: 216))
        }
    }
}
