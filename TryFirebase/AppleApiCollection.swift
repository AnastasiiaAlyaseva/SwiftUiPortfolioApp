//
//  AppleApiCollection.swift
//  TryFirebase
//
//  Created by Anastasiia Alyaseva on 10.05.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore
//import Combine

class ImageLoader: ObservableObject {
    //    @Published var imageData: Data = UIImage(systemName: "photo")?.pngData() ?? Data()
    
    //URLSession private var cancellable: AnyCancellable?
    
    @Published var imageData = Data()
    @Published var imageDatas = [Data]()
    
    //    init(url: String) {
    //        guard let imageURL = URL(string: url) else {
    //            return
    //        }
    //
    //        DispatchQueue.global().async {
    //            if let data = try? Data(contentsOf: imageURL) {
    //                DispatchQueue.main.async {
    //                    self.imageData = data
    //                    self.imageDatas.append(data)
    //                }
    //            } else {
    //                print("url is not correct \(imageURL)")
    //            }
    //        }
    //    }
    
    
    func loadImage(from url: String, completion: @escaping (Data)->()) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    completion(data)
                }
            } else {
                print("url is not correct \(imageURL)")
            }
        }
    }
    
    
    func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.imageData = data
                    self.imageDatas.append(data)
                }
            } else {
                print("url is not correct \(imageURL)")
            }
        }
        
        //        URLSession.shared.dataTask(with: imageURL) { data, response, error in
        //            guard error != nil else {
        //                print("Error getting documents data: \(error)")
        //                return
        //            }
        //
        //            if let data = data {
        //                DispatchQueue.main.async {
        //                    self.imageData = data
        //                }
        //            }
        //        }.resume()
        
        //        cancellable = URLSession.shared.dataTaskPublisher(for: imageURL)
        //            .map{$0.data}
        //            .replaceError(with: Data())
        //            .receive(on: DispatchQueue.main)
        //            .assign(to: \.imageData, on: self)
    }
}

struct AppleApiCollection: View {
    //@StateObject private var imageLoader = ImageLoader()
    @StateObject private var storage = Storage()
    
    private let db = Firestore.firestore()
    
    @State var gridLayout: [GridItem] = [GridItem()]
    
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                    
                    ForEach(storage.imageDatas.indices, id: \.self) { index in
                        
                        if let uiImage = UIImage(data: storage.imageDatas[index]) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .cornerRadius(10)
                                .shadow(color: Color.primary.opacity(0.3), radius: 1)
                        } else {
                            // todo
                            Text("Loading Image Data! Please wait!")
                        }
                        
                    }
                }
                .padding(.all, 10)
            }
            
        }
        .onAppear {
            self.loadImageFromFirebase()
        }
    }
    
    func loadImageFromFirebase(){
        db.collection("image").getDocuments{ (querySnapshot,error) in
            if let error = error {
                print("Error getting documents data: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    if let imageUrl = document.data()["image"] as? String {
                        //storage.imageUrls.append(imageUrl)
                        //imageLoader.loadImage(from: imageUrl)
                        
                        ImageLoader().loadImage(from: imageUrl) { data in
                            storage.imageDatas.append(data)
                        }
                    }
                }
                
                //print(storage.imageUrls)
            }
            
        }
    }
}

struct AppleApiCollection_Previews: PreviewProvider {
    static var previews: some View {
        AppleApiCollection()
    }
}
