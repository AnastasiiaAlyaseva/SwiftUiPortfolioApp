import Firebase
import FirebaseFirestore

class FirebaseService: ObservableObject {
    
    var storage = Storage()    
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
                        }
                    }
                }
            }
        }
    }
    
}
