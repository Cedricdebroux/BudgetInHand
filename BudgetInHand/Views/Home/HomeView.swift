//
//  HomeView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 07/12/2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var fetchCurrentUserViewModel = UserViewModel()
    
    var isClickable = true
    var valuesPie : [Double] = [300,400,600,500]
    var namePie : [String] = ["Carburant","Energie","Comissions","Charges"]
    var colorChart: [Color] = [Color.fromInts(r: 0, g: 181, b: 216), Color.fromInts(r: 0, g: 119, b: 182),Color.fromInts(r: 144, g: 224, b: 238),Color.fromInts(r: 3, g: 4, b: 94)]
    let imageArray = ["car.fill","bolt.fill","cart.fill","house.fill"]
    var angleSpace: [Angle] = [Angle(degrees: 3)]
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
                    if (Date.now.formatted(date: .omitted, time: .shortened)) <= "17:00:00"{
                        Text("Bonjour")
                    } else {
                        Text("Bonsoir")
                    }
                    Text(fetchCurrentUserViewModel.currentUser?.name ?? "")
                }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            .foregroundColor(Color("Blue600"))
                PieChartView(
                    isClickable: isClickable,
                    values: valuesPie,
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
                .frame(height: 300)
                .scaledToFit()
            HStack{
                
                List {
                    ForEach(0..<3) { _ in
                        Text("Integer")
                    }.preferredColorScheme(.light)
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
