//
//  NewExpenseView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 05/12/2022.
//

import SwiftUI

struct NewExpenseView: View {
    @EnvironmentObject var appModel: BudgetInHandModel
    @ObservedObject private var viewModel = ExpenseViewModel()
   
    @State private var presentAlert = false
    @State private var titleText = ""
    @State private var amountText: Float = 0.0
    @State private var date = Date()
    @State private var category : Category = .carburant
    @State private var textPicker: String = ""
    @State private var userId = ""

    var body: some View {
        VStack{
            
            TextField("Enter the amount", value: $amountText, format: .number)
            Spacer(minLength: 0.2)
            TextField("Enter the title", text: $titleText)
            
            DatePicker("Quel jour est on?",selection:$date,displayedComponents: [.date])
            
            List {
                Picker("Categories", selection: $category){
                    ForEach(Category.allCases) {
                        category in
                        Text(category.rawValue.capitalized)
                        
                    }
                }
                
            }
            
            Button("Save", action: {
            textPicker = ("\(self.category.rawValue.capitalized)")
                
                // post the text to Firestore, then erase the text:
                self.viewModel.addData(userId: appModel.userId ?? "",title: titleText, amount: amountText, category: textPicker, date: date)
                
                titleText = ""
                amountText = 0.0
                category = Category.carburant
                date = Date()
                                                    
            })
        }
        NavigationStack {

            List {
                ForEach(viewModel.expenses, id:\.id) { Expense in
                    
                    VStack(alignment: .leading) {
                        Text(Expense.title ?? "").font(.system(size: 18, weight: .regular))
                    }.frame(maxHeight: .none)
                    
                }
            }.onAppear(perform :{ self.viewModel.fetchData(
                userId: appModel.userId ?? "")})
                .navigationTitle("Expense")
                .toolbar {
                   ToolbarItem(placement: .bottomBar) {
                       Text("\(viewModel.expenses.count) expenses")
                   }
                   ToolbarItem(placement: .bottomBar) {
                       Button {
                           presentAlert = true
                       }
                   label: {
                       Image(systemName: "square.and.pencil")
                           .imageScale(.large)
                           .bold()
                           .accentColor(.yellow)
                   }
                   }
               }
               }.accentColor(.brown)
    }
}

struct NewExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        NewExpenseView()
    }
}
