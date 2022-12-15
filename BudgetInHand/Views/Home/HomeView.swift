//
//  HomeView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 07/12/2022.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel = ExpenseViewModel()
    @EnvironmentObject var appModel: BudgetInHandModel
    
    
    
    var isClickable = true
    var budgetTotalCategory: [Double] = [500,600,800,800]
    
    var valuesPie : [Double] = [300,400,600,500]
    
    var namePie : [String] = [Category.Carburant.rawValue,Category.Energie.rawValue,Category.Commission.rawValue,Category.Domicile.rawValue]
    var colorChart: [Color] = [Color.fromInts(r: 0, g: 181, b: 216), Color.fromInts(r: 0, g: 119, b: 182),Color.fromInts(r: 144, g: 224, b: 238),Color.fromInts(r: 3, g: 4, b: 94)]
    let imageArray = ["car.fill","bolt.fill","cart.fill","house.fill"]
    var angleSpace: [Angle] = [Angle(degrees: 3)]
    
    
    func switchIcone(category: [String]) -> String{
        switch category {
        case ["Carburant"]:
            return "car.fill"
            
        case ["Energie"]:
            return "bolt.fill"
            
        case ["Commission"]:
            return "cart.fill"
            
        case ["Domicile"]:
            return "house.fill"
            
        default:
            return ""
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                PieChartView(
                    isClickable: isClickable,
                    values: valuesPie,
                    budgetTotal: budgetTotalCategory,
                    names: namePie,
                    formatter: { $0.description },
                    colors: colorChart,
                    iconNames: imageArray,
                    backgroundColor: Color.fromInts(r: 250,
                                                    g: 250,
                                                    b: 250), angleSpace: Angle(degrees: 3))
            }
            Spacer()
                .frame(height: 300)
                .scaledToFit()
            HStack{
                NavigationStack{
                    
                    List {
                        Section {
                            Text("Vos dernières dépenses :")
                        }
                        ForEach(viewModel.expenses, id:\.id) { Expense in
                            HStack() {
                                
                                /*
                                 //date
                                 Text(String(from: Expense.date ?? "" )).font(.system(size: 18, weight: .regular))
                                 */
                                
                                
                                //                                        if Expense.category == [namePie].description {
                                
                                HStack{
                                    
                                    //.foregroundColor(Color("Blue100"))
                                    //category de l'expense
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5.0)
                                            .fill(Color("Blue600"))
                                        // adevelloper plus ytard mettre la cardbox en fond de l'icon de la couleur du type de la categorie
                                            .frame(width: 20, height: 20)
                                        Image(systemName:switchIcone(category: [String(Expense.category ?? "house.fill")]))
                                            .foregroundColor(Color(.white))
                                            .aspectRatio(contentMode: .fit)
                                    }
                                    //Text("-").font(.system(size: 12, weight: .regular))
                                    Text(Expense.title ?? "" )
                                        .font(.system(size: 18, weight: .regular))
                                        .bold()
                                    //                                    Text(Expense.category ?? "" )
                                    //                                        .font(.system(size: 12, weight: .regular))
                                    //                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text(Expense.date ?? Date.now, style: .date )
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.gray)
                                Spacer()
                                
                                //amount de l'expense
                                HStack{
                                    Text(String(Expense.amount ?? 0.0) )
                                        .font(.system(size: 18, weight: .regular))
                                        .frame(maxHeight: .none)
                                        .bold()
                                    Text("€")
                                }
                            }
                        }
                    }.onAppear(perform :{ self.viewModel.fetchData(userId: appModel.userId ?? "")})
                }
            }
        }
    }
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
