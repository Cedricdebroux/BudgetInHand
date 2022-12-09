//
//  DetailExpenses.swift
//  BudgetInHand
//
//  Created by Germain Buchet on 08/12/2022.
//

import SwiftUI

struct DetailExpenses: View {
    @StateObject var isOpebDetail = BudgetInHandModel()
    isOpenDetail = false
    
    var angleSpace: Angle = Angle(degrees: 0)

    //var budgetUsed: Double = [300,300]
    //var budgetTotal: Double = 500
    
    /*
     
     init() {
     self.budgetUsed = 300
     self.budgetTotal = 500
     }
     */
    
    var valuesPie : [Double] = [300]
    //var budgetTotal : [Double] = [500]
    
    /*
     init() {
     self.valuesPie = [300,500]
     self.budgetTotal = [500]
     }
     */
    
    //var resultValue : Double = valuesPie / budgetTotal
    
    var namePie : [String] = ["Carburant"]
    //"Total"
    var colorChart: [Color] = [Color.fromInts(r: 0, g: 181, b: 216)]
    //Color.fromInts(r: 128, g: 128, b: 128)
    
    var numberTotalExpenses : Int = 10
    
    let imageArray = ["car.fill"]
    
    var body: some View {
        
        //aluesPie = [budgetUsed,budgetTotal]
        
        VStack{
            
            VStack{
                PieChartView(
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
