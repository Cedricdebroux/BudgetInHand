//
//  HomeView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 07/12/2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var fetchCurrentUserViewModel = UserViewModel()
    
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
    func switchColors(category: [String]) -> Color{
        switch category {
        case ["Carburant"]:
            return Color.fromInts(r: 0, g: 181, b: 216)
            
        case ["Energie"]:
            return Color.fromInts(r: 0, g: 119, b: 182)
            
        case ["Commission"]:
            return Color.fromInts(r: 144, g: 224, b: 238)
            
        case ["Domicile"]:
            return Color.fromInts(r: 3, g: 4, b: 94)
            
        default:
            return Color("Green600")
        }
    }
    
    var body: some View {
        VStack{
            
            HStack{
                    AsyncImage(url: URL(string: fetchCurrentUserViewModel.currentUser?.profileImageUrl ?? ""), content: {image in
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
                            
                    }, placeholder: {Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(25)
                    })
                    .cornerRadius(25)
                    .overlay(RoundedRectangle(cornerRadius: 35)
                        .stroke(Color("Blue600"), lineWidth: 1))
                    .scaledToFit()
                        Text("Bonjour")
                    Text(fetchCurrentUserViewModel.currentUser?.name ?? "")
                }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            .foregroundColor(Color("Blue600"))
                PieChartView(
                    isClickable: isClickable,
                    values: valuesPie,
                    budgetTotal: budgetTotalCategory,
                    names: namePie,
                    formatter: { $0.description },
                    colors: colorChart,
                    iconNames: imageArray,
                    backgroundColor: Color.fromInts(
                        r: 250,
                        g: 250,
                        b: 250), angleSpace: Angle(degrees: 3)
                )
            
            Spacer()
                .frame(height: 320)
                .scaledToFit()
            HStack{

                NavigationStack{
                    Spacer()
                    Text("Vos dernières dépenses :")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    List {
                        ForEach(viewModel.expenses, id:\.id) { Expense in
                            HStack() {
                                HStack{
                                ZStack{
                                        RoundedRectangle(cornerRadius: 5.0)
                                        .fill(switchColors(category: [String(Expense.category ?? "house.fill")]))
                                            .frame(width: 20, height: 20)
                                        Image(systemName:switchIcone(category: [String(Expense.category ?? "house.fill")]))
                                            .foregroundColor(Color(.white))
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 50)
                                    }
                                }
                                
                                Spacer()
                                
                                Text(Expense.date ?? Date.now, style: .date )
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.gray)
//                                    .frame(minWidth: 180)
                                Spacer()

                                HStack(){
                                    Text(String(Expense.amount ?? 0.0))
                                        .font(.system(size: 18, weight: .regular))
                                        .frame(maxHeight: .none)
                                        .bold()
                                        .frame(maxWidth: 140, alignment: .trailing)
                                    Spacer()
                                    Text("€")
                                }
                            }
                        }
                    }.onAppear(perform :{ self.viewModel.fetchData(userId: appModel.userId ?? "")})
                }
            }
        }
        .background(Color("Gray100"))

    }

    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
