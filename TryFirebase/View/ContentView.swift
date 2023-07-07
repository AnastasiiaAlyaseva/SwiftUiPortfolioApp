import SwiftUI

struct TryFirebaseHomePage: View {
    
    private let colors = [
        Color(red:0.996 , green:0.878 , blue:0.925),
        Color(red:0.925 , green: 0.976 , blue:0.949)
    ]
    
    private let devName = "Anastasiia"
    @State private var isVisible = false
    
    
    var body: some View {
        NavigationView() {
            ZStack{
                Color(red:0.57, green:0.181, blue:0.224).edgesIgnoringSafeArea(.all)
                LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text(devName.uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                        .opacity(isVisible ? 1:0)
                        .offset(y:isVisible ? 0:30)
                        .animation(.easeOut(duration: 1).delay(0.5), value: isVisible)
                    
                    Image("Anastasiia")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 150, height: 150)
                        .padding(.bottom, 10)
                    
                    Text("A Passionate developer who recently started learning Swift and IOS development. Commited to creating high-quality apps and continuously improving skills")
                        .font(.body)
                        .fontWeight(.medium)
                        .padding([.top, .leading, .trailing])
                        .multilineTextAlignment(.leading)
                        .opacity(isVisible ? 1:0)
                        .offset(y:isVisible ? 0:30)
                        .animation(.easeOut(duration: 1).delay(0.5), value: isVisible)
                    
                    VStack{
                        NavigationLink(destination: ContactForm()){
                            Text("Contact the Developer⚡️")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.black)
                                .cornerRadius(15)
                        }
                    }
                    .padding(.top, 50)
                    .padding(.bottom,30)
                    
                    NavigationLink(destination:LoadFromApiCollection()) {
                        Label("Load images from API", systemImage: "gamecontroller")
                    }
                    Spacer ()
                    Text("@2023")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .padding(.bottom)
                }
            }
            .navigationBarHidden(true)
            .onAppear{
                isVisible = true
            }
        }
    }
}


struct TryFirebaseHomePage_Bulder:PreviewProvider{
    static var previews: some View{
        TryFirebaseHomePage()
    }
}
