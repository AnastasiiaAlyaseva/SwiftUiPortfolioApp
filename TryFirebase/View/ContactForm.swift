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
    @State private var showingAlert = false
    var messegeOptions = ["All", "Request", "Grievance"]
    
    var body: some View {
        
        NavigationView{
            Form {
                Section(header: Text("Tell us about yourself 📣")) {
                    EditFieldView(text: $name, placeholder: "Name", isValid: isValidName)
                    EditFieldView(text: $replyTo, placeholder: "Email", isValid: isValidEmail)
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
                        }
                        print("Can't use the Simulator, to send Emails.")
                        showingAlert = true
                    }) {
                        Text("Send your message")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.mint)
                            .cornerRadius(15)
                    }
                    .disabled(name.isEmpty || replyTo.isEmpty)
                    .alert(isPresented:$showingAlert) {
                        Alert(
                            title: Text("Your message has been sent"),
                            dismissButton: .default(Text("Ok"))
                        )
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
    
    private func isValidName(text: String) -> (Bool, String) {
        let isValid = !text.isEmpty
        let errorMessage = isValid ? "" : "Cannot be empty"
        return (isValid, errorMessage)
    }
    
    private func isValidEmail(text: String) -> (Bool, String) {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicateEmail = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValid =  predicateEmail.evaluate(with: text)
        let errorMessage = isValid ? "" : "Invalid email"
        return (isValid, errorMessage)
    }
}

struct ContactForm_Previews: PreviewProvider {
    static var previews: some View {
        ContactForm()
    }
}
