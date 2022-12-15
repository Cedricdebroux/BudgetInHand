//
//  NewExpenseView.swift
//  BudgetInHand
//
//  Created by Quentin Bona on 05/12/2022.
//

import SwiftUI
import FirebaseStorage
import Firebase
import FirebaseFirestore

struct NewExpenseView: View {
    
    private var databaseReference = Firestore.firestore().collection("Expenses")
    
    @EnvironmentObject var appModel: BudgetInHandModel
    @ObservedObject private var viewModel = ExpenseViewModel()
    
    @State private var presentAlert = false
    
    @State private var amountText: Float = 0.0
    @State private var date = Date()
    @State private var category : Category = .carburant
    @State private var  textPicker: String = ""
    @State private var userId = ""
    @State private var shouldShowImagePicker = false
    @State private var image: UIImage?
    @State private var loginStatusMessage = ""
    
    var body: some View {
        
        ZStack{
            Color("Gray300")
                .ignoresSafeArea()
            
            VStack{
                Text("Création d'une nouvelle dépense")
                    .font(.title2)
                    .foregroundColor(Color("Blue600"))
                
                Spacer()
                
                Button {
                    shouldShowImagePicker
                        .toggle()
                } label: {
                    VStack{
                        if let image = self.image{
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 180, height: 180)
                               
                        } else {
                            Image(systemName: "camera.fill")
                                .font(.system(size: 90))
                                .padding()
                                .foregroundColor(Color("Blue600"))
                        }
                    }
                    
                        
                }
                
                Form{
                    Section("Categorie"){
                        List {
                            Picker("Categories", selection: $category){
                                ForEach(Category.allCases) {
                                    category in
                                    Text(category.rawValue.capitalized)
                                }
                            }
                        }
                    }
                    Section("Montant"){
                        TextField("Enter the amount", value: $amountText, format: .number)}
                    
                    Section("Date"){
                        DatePicker("Quel jour est on?",selection:$date,displayedComponents: [.date])
                    }
                }
                
                VStack{
                    Button("Save", action: {
                        textPicker = ("\(self.category.rawValue.capitalized)")
                        self.persistImageToStorage(){ imageUrl in
                            
                            self.viewModel.addData(userId: appModel.userId ?? "",category: textPicker, amount: amountText, date: date, image: imageUrl)
                        }
                        
                        // post the text to Firestore, then erase the text:
                
                        amountText = 0.0
                        category = Category.carburant
                        date = Date()
                        
                    }).buttonStyle(.borderedProminent)
                }
                
                Spacer()
                
                //            NavigationStack {
                //                List {
                //                    ForEach(viewModel.expenses, id:\.id) { Expense in
                //
                //                        VStack(alignment: .leading) {
                //                            Text(Expense.title ?? "").font(.system(size: 18, weight: .regular))
                //                        }.frame(maxHeight: .none)
                //
                //                    }
                //                }.onAppear(perform :{ self.viewModel.fetchData(
                //                    userId: appModel.userId ?? "")})
                //                .navigationTitle("Expense")
                //                .toolbar {
                //                    ToolbarItem(placement: .bottomBar) {
                //                        Text("\(viewModel.expenses.count) expenses")
                //                    }
                //                    ToolbarItem(placement: .bottomBar) {
                //                        Button {
                //                            presentAlert = true
                //                        }
                //                    label: {
                //                        Image(systemName: "square.and.pencil")
                //                            .imageScale(.large)
                //                            .bold()
                //                            .accentColor(.yellow)
                //                    }
                //                    }
                //                }
                //            }.accentColor(.brown)
            }
        }.ignoresSafeArea(.keyboard)
            .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil){
                ImagePicker(image: $image)
            }
    }
   
    
    private func persistImageToStorage(completionHandler: @escaping (String) -> Void ){
        let fileName = UUID().uuidString
        guard let uid =
                Auth.auth().currentUser?.uid
        else { return }
        let ref = Storage.storage().reference(withPath: uid )
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5)
        else { return }
        ref.putData(imageData,metadata: nil) { metadata, err in
            if let err = err {
                self.loginStatusMessage = "Failed to push image to Storage : \(err)"
                return
            }
            ref.downloadURL{url, err in
                if let err = err {
                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
                    return
                }
                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                print(url?.absoluteString)
                guard let url = url else { return }
                completionHandler(url.absoluteString)
 
            }
        }
    }
   
}



struct NewExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        NewExpenseView()
    }
}
