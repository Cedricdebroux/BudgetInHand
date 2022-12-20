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
import Combine

struct NewExpenseView: View {
    
    private var databaseReference = Firestore.firestore().collection("Expenses")
    
    @EnvironmentObject var appModel: BudgetInHandModel
    @ObservedObject var viewModel = ExpenseViewModel()
    

    @State var presentAlert = false
    @State private var amountText: Float = 0
    @State private var date = Date()
    @State private var category : Category = .Carburant
    @State private var textPicker: String = ""
    @State private var userId = ""
    @State private var shouldShowImagePicker = false
    @State private var image: UIImage?
    @State private var loginStatusMessage = ""
    @State private var showAlert = false
    @State private var isExpenseValidate = false
    @State private var showAlertExpense = false
   
    var body: some View {
        NavigationStack{
            ZStack{
                Color("Gray300")
                    .ignoresSafeArea()
                
                VStack{
                    Text("Création d'une nouvelle dépense")
                        .font(.title2)
                        .foregroundColor(Color("Blue600"))
                    
                    Spacer()
                    
                    Button {
                        showAlert.toggle()
                       
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
                        .alert("Methode d'encodage d'une dépense",isPresented: $showAlert){
                            Button("Manuellement", role: .cancel){
                                shouldShowImagePicker
                                    .toggle()
                            }
                            Button("Avec l'aide de l'appareil photo", role: .none){
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
                            TextField("Entrez votre dépense", value: $amountText, formatter: NumberFormatter())}
                        
                        Section("Date"){
                            DatePicker("Quel jour est on?",selection:$date,displayedComponents: [.date])
                        }
                    }
                    
                    VStack{
                        
                        Button(action: {
                            textPicker = ("\(self.category.rawValue.capitalized)")
                            createExpense()
                            // post the text to Firestore, then erase the text
                            
                        }, label:{
                            Text("Sauvegarder")
                                .frame(maxWidth: 300)
                            
                        })
                        .buttonStyle(.borderedProminent)
                        .tint(Color("Blue600"))
                        .controlSize(.large)
                        .foregroundColor(Color.white)
                        .alert("Cette dépense a bien été enregistrée",isPresented: $showAlertExpense){
                            HStack{
                                Button("Nouvelle", role: .cancel){
                                    amountText = 0.0
                                    date = Date()
                                    category = Category.Carburant
                                    image = UIImage(systemName: "camera.fill")
                                        
                                }
                                Button("Accueil", role: .none){
                                    isExpenseValidate.toggle()
                                }
                                .navigationDestination(isPresented: $isExpenseValidate){

                                    MainView()
                                }
                            }
                        }
                        
                    }
                    Spacer()
                }
            }.ignoresSafeArea(.keyboard)
                .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil){
                    ImagePicker(image: $image)
                }
               
                .navigationBarBackButtonHidden(true)
          
        }
    }
    
    private func createExpense(){
        DispatchQueue.main.async {
            self.persistImageToStorage(){ imageUrl in
                self.viewModel.addData(userId: Auth.auth().currentUser?.uid  ?? "",category: textPicker, amount: amountText, date: date, image: imageUrl)
                showAlertExpense.toggle()
            }
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
//            isExpenseValidate.toggle()
//        }
    
    }
    
    
    private func persistImageToStorage(completionHandler: @escaping (String) -> Void ){
        let fileName = UUID().uuidString
        let uid = UUID()
        let ref = Storage.storage().reference(withPath: "\(uid)" )
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
