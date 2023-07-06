import SwiftUI
import Firebase
import FirebaseFirestore

class FirebaseService {
    
    var storage = Storage()
    
    //
    var storageTest: Storage
    
    private let firestore = Firestore.firestore()
    
    func loadImageFromFirebase(){
        firestore.collection("image").getDocuments{ (querySnapshot,error) in
            if let error = error {
                print("Error getting documents data: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    if let imageUrl = document.data()["image"] as? String {
                        ImageLoader().loadImage(from: imageUrl) { data in
                            self.storage.imageDatas.append(data)
                            print(self.storage.imageDatas.count)
                            
                            
                            self.storageTest.testData.append(self.storage.imageDatas.count)
                        }
                    }
                }
            }
        }
    }
    
    init(storage: Storage = Storage(), storageTest: Storage) {
        self.storage = storage
        self.storageTest = storageTest
    }
}
