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
    @State private var amountText = ""
    @State private var dateText = ""
    @State private var category = ""
    @State private var userId = ""
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.expenses, id:\.id) { Expense in
                    
                    VStack(alignment: .leading) {
                        Text(Expense.title ?? "").font(.system(size: 18, weight: .regular))
                    }.frame(maxHeight: .none)
                    
                }
            }.onAppear(perform :{ self.viewModel.fetchData(userId: appModel.userId!)})
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
                .alert("Expense", isPresented: $presentAlert, actions: {
                    TextField("Enter the title", text: $titleText)
                    TextField("Enter the amount", text: $amountText)
                    TextField("Enter your date", text: $dateText)
                    TextField("Enter the category", text: $category)
                    
                    
                    Button("Save", action: {
                        // post the text to Firestore, then erase the text:
                        self.viewModel.addData(userId: appModel.userId ?? "",title: titleText, amount: amountText, category: category, date: dateText)
                                                            
                    })
                    Button("Cancel", role: .cancel, action: {
                        presentAlert = false
                        titleText = ""
                    })
                }, message: {
                    Text("Please, enter your expense")
                })
        }.accentColor(.brown)
            
    }
}

struct NewExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        NewExpenseView()
    }
}
