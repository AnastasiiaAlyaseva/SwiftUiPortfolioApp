import SwiftUI
import iPhoneNumberField

struct ContactForm: View {
    
    @State private var isShowingMailView = false
    @State private var name: String = ""
    @State private var message: String = ""
    @State private var replyTo: String = ""
    @State private var number: String = ""
    @State private var isEditing: Bool = false
    @State private var subjectLine: String = ""
    var messegeOptions = ["All", "Request", "Grievance"]
    
    var body: some View {
        
        NavigationView{
            Form {
                Section(header: Text("Tell us about yourself 📣")) {
                    TextField("Name", text: $name)
                    TextField("Email", text: $replyTo)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                Section(header: Text("Phone number ☎️")){
                    iPhoneNumberField("Phone", text: $number, isEditing: $isEditing)
                }
                
                Section(header: Text("Message 📧")) {  Picker(selection: $subjectLine, label: Text("Message subject")) {
                    Text("All").tag(0)
                    Text("Request").tag(1)
                    Text("Grievance").tag(1)
                }
                    TextEditor(text: $message)
                }
                
                Section {
                    Button(action: {
                        if MailView.canSendMail() {
                            isShowingMailView.toggle()
                        }  else {
                            print("Cant use the Simulator, to send Emails.")
                        }
                    }) {
                        Text("Send your message")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.mint)
                            .foregroundColor(Color.black)
                            .cornerRadius(15)
                    }
                    .fullScreenCover(isPresented: $isShowingMailView) {
                        MailView(name: name, replyTo: replyTo, message: message)
                    }
                }
            }
            .navigationTitle("Send me a message 📧")
        }
    }

    func sendFormEmail() {
        isShowingMailView = true
    }
}

struct ContactForm_Previews: PreviewProvider {
    static var previews: some View {
        ContactForm()
    }
}
