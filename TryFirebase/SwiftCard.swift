//
//  SwiftCard.swift
//  TryFirebase
//
//  Created by Anastasiia Alyaseva on 25.03.2023.
//

import SwiftUI

struct SwiftCard: View {
    @State private var textColor = Color.black
    
    @State private var fixedcardColor = Color.white
    
    @State private var fontSize : Int = 0
    
    @State private var colorIndex = 0 //Setting the array start point
    
    let colors: [Color] = [
        .red,
        .yellow,
        .blue
    ]
    let cardColor : [Color] = [
        .brown,
        .mint,
        .purple
    ]
    let fontSizes : [CGFloat] = [
        20,
        30,
        40,
        50
    ]
    
    var body: some View {
        VStack{
            Image("")
            Text("Card Title")
                .font(.system(size: fontSizes[fontSize]))
                .fontWeight(.medium)
                .foregroundColor(textColor)
                .padding()
                .onAppear{}
            Button(action:{
                changeCardTextColor()
            }){
                Text("Card Button")
            }
            Picker("Change Card Font Size", selection: $fontSize) {
                ForEach(0..<fontSizes.count){ index in
                    Text("\(Int(fontSizes[index]))")
                }
            }
            .padding()
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
        .background(fixedcardColor)
        .cornerRadius(10)
    }
    private func changeCardTextColor() {
        //    let nextColor = (colors.firstIndex(of: textColor) ?? 0 + 1) % colors.count
        let currentColor = colors.firstIndex(of: textColor) ?? 0
        let nextColor = (currentColor + 1) % colors.count
        
        print(nextColor)
        textColor = colors[nextColor]
        
        let currentCardColor = cardColor.firstIndex(of: fixedcardColor) ?? 0
        let nextCardColor = (currentColor + 1) % cardColor.count
        
        fixedcardColor = cardColor[nextCardColor]
        
        //        let currentColor = colors.firstIndex(of: textColor) ?? 0: This part finds the index of the current textColor in the colors array. If it finds the index, it returns the index; otherwise, it returns 0.
        //
        //        let nextColor = (currentColor + 1) % colors.count: This part adds 1 to the currentColor index and calculates the remainder of dividing the result by the count of the colors array. This ensures that the index wraps around to the start of the array when it reaches the end.
        //
        //        print(nextColor): This line prints the value of nextColor to the console.
        //
        //        textColor = colors[nextColor]: This line updates the textColor with the next color from the colors array using the calculated nextColor index.
    }
}

struct SwiftCard_Previews: PreviewProvider {
    static var previews: some View {
        SwiftCard()
    }
}
