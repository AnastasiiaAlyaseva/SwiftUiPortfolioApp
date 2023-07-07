import Foundation
import Combine

class ImageLoader: ObservableObject {
    
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
    
}

// Not using now in the app
// loading via URLSession
class ImageLoader2: ObservableObject {
    
    @Published var imageData = Data()
    @Published var imageDatas = [Data]()
    
    private var cancellable: AnyCancellable?
    
    init(url: String) {
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
    }
    
    func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard error != nil else {
                print("Error getting documents data: \(String(describing: error))")
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.imageData = data
                }
            }
        }.resume()
        
        cancellable = URLSession.shared.dataTaskPublisher(for: imageURL)
            .map{$0.data}
            .replaceError(with: Data())
            .receive(on: DispatchQueue.main)
            .assign(to: \.imageData, on: self)
    }
}
