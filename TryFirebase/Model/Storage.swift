import Foundation

class Storage: ObservableObject {

    @Published var imageDatas = [Data]()
    
    @Published var testData: [Int] = [1,2,3,4,5,6,7,8,9,10]

}
