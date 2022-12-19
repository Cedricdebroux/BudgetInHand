//
//  DetailExpenses.swift
//  BudgetInHand
//
//  Created by Germain Buchet on 08/12/2022.
//

import SwiftUI


struct DetailExpenses: View {
    @ObservedObject private var viewModel = ExpenseViewModel()
    @EnvironmentObject var appModel: BudgetInHandModel
    
    private var budgetTotalCarbu: [Double] = [400]
    private var colorBudgetTotal = Color.fromInts(r: 250,g: 250,b: 250)
    @StateObject private var showDetail = BudgetInHandModel()
    private var angleSpace: Angle = Angle(degrees: 0)
    private var isClickable: Bool = false
    var valuesPie : [Double] = []
    let budgetTotal: [Double]
    let namePie : [String]
    let namePieSingle : String
    let colorChart: [Color]
    private var numberTotalExpenses : Int = 10
    let imageArray: [String]
    
    let dateFormatter = DateFormatter()
    
    
    //let categoryDB : [String]
    
    
    @State private var userId = ""
    
    init(value: Double,budgetTotalCategory: Double, name: String, image: String, colors: Color) {
        valuesPie = [value]
        budgetTotal = [budgetTotalCategory]
        namePie = [name]
        namePieSingle = name
        imageArray = [image]
        colorChart = [colors]
    }
    private func showGraph(value: [Double]){
        // values: valuesPie
        PieChartView(
            isClickable : isClickable,
            values: value ,
            budgetTotal: budgetTotal,
            names: namePie,
            formatter: { $0.description },
            colors: colorChart,
            iconNames: imageArray,
            backgroundColor: Color.fromInts(r: 250,
                                            g: 250,
                                            b: 250),
            angleSpace: Angle(degrees: 0))
    }
    

    var body: some View {
        HStack{
            VStack{
                PieChartView(
                    isClickable : isClickable,
                    values: valuesPie ,
                    budgetTotal: budgetTotal,
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
                        ForEach(viewModel.expenses, id:\.id) { Expense in
                            HStack() {
                                Spacer()
                                Text(Expense.date ?? Date.now, style: .date )
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.gray)
                                Spacer()
                                HStack{
                                    Text(String(Expense.amount ?? 0.0) )
                                        .font(.system(size: 18, weight: .regular))
                                        .frame(maxHeight: .none)
                                        .bold()
                                    Text("€")
                                }
                            }
                        }
                    }
                    .onAppear(perform :{ self.viewModel.fetchDataCategory(userId: appModel.userId ?? "",category: namePieSingle )
                        
                    })
                }
            }
        }
    }

    struct DetailExpenses_Previews: PreviewProvider {
        static var previews: some View {
            DetailExpenses(value: 300,budgetTotalCategory: 500, name: "test", image: "cars", colors: Color.fromInts(r: 0, g: 181, b: 216))
        }
    }
}
