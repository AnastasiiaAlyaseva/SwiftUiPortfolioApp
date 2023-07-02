import SwiftUI

struct LoadFromApiCollection: View {

    @StateObject private var firebaseService = FirebaseService()
    @State var gridLayout: [GridItem] = [GridItem()]
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                    ForEach(firebaseService.storage.imageDatas.indices, id: \.self) { index in
                        if let uiImage = UIImage(data: firebaseService.storage.imageDatas[index]) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .cornerRadius(10)
                                .shadow(color: Color.primary.opacity(0.3), radius: 1)
                        } else {
                            Text("Loading Image Data! Please wait!")
                        }
                        
                    }
                }
                .padding(.all, 10)
            }
        }
        .onAppear {
            firebaseService.loadImageFromFirebase()
        }
    }
    
}

struct LoadFromApiCollection_Previews: PreviewProvider {
    static var previews: some View {
        LoadFromApiCollection()
    }
}
