import SwiftUI
import Firebase
import FirebaseFirestore

class FirebaseService {
    
    private var imageStorage: Storage
    private let firestore = Firestore.firestore()
    
    init(imageStorage: Storage) {
        self.imageStorage = imageStorage
    }
    
    func loadImageFromFirebase() {
        firestore.collection("image").getDocuments{ (querySnapshot,error) in
            if let error = error {
                print("Error getting documents data: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    if let imageUrl = document.data()["image"] as? String {
                        ImageLoader().loadImage(from: imageUrl) { data in
                            self.imageStorage.imageDatas.append(data)
                        }
                    }
                }
            }
        }
    }
}
