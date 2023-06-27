//
//  ContactForm.swift
//  TryFirebase
//
//  Created by Anastasiia Alyaseva on 08.04.2023.
//

import SwiftUI
import MessageUI
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
                Section(header: Text("Tell us about yourself📣")) {
                    TextField("Name", text: $name)
                    TextField("Email", text: $replyTo)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                Section(header: Text("Phone number☎️")){
                    iPhoneNumberField("Phone", text: $number, isEditing: $isEditing)
                }
                
                
                Section(header: Text("Message📧")) {  Picker(selection: $subjectLine, label: Text("Message subject")) {
                    Text("All").tag(0)
                    Text("Request").tag(1)
                    Text("Grievance").tag(1)
                }
                    TextEditor(text: $message)
                }
                Section {
                    Button(action: {
                        if MFMailComposeViewController.canSendMail()
                        {
                            isShowingMailView.toggle()
                        }  else {
                            print("Cant use the Simulator, to send Emails.")
                        }
                    }) {
                        Text("Send you message")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.mint)
                            .foregroundColor(Color.black)
                            .cornerRadius(15)
                    }
                    //                    .sheet(isPresented: $isShowingMailView) {
                    //                        MailView(name: name, replyTo: replyTo, message: message)
                    .fullScreenCover(isPresented: $isShowingMailView) {
                        MailView(name: name, replyTo: replyTo, message: message)
                    }
                }
            }
            .navigationTitle("Send us a Massage📧")
        }
    }
    
    
    
    
    
    //        VStack{
    //            TextField("Your name", text: $name)
    //                .padding()
    //                .border(Color.black, width: 1)
    //            TextField("Your Email", text: $replyTo)
    //                .padding()
    //                .border(Color.black, width: 1)
    //                .keyboardType(.emailAddress)
    //                .autocapitalization(.none)
    //            TextField("Say hi", text: $message)
    //                .frame(minWidth: 0, maxWidth: .infinity)
    //                .padding()
    //                .background(Color.mint)
    //                .foregroundColor(Color.black)
    //                .cornerRadius(15)
    //
    //            Button(action:sendFormEmail) {
    //                Text("Send you message")
    //                    .frame(minWidth: 0, maxWidth: .infinity)
    //                    .padding()
    //                    .background(Color.mint)
    //                    .foregroundColor(Color.black)
    //                    .cornerRadius(15)
    //            }
    //        }
    
    func sendFormEmail() {
        isShowingMailView = true
    }
}


struct MailView: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentation
    
    var name : String
    var replyTo : String
    var message : String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController{
        //This line of code creates a new instance of MFMailComposeViewController, which is a view controller for displaying a pre-populated email composition interface.
        let mailComposeViewController = MFMailComposeViewController()
        //This line of code creates a new instance of MFMailComposeViewController, which is a view controller for displaying a pre-populated email composition interface.
        mailComposeViewController.mailComposeDelegate = context.coordinator
        
        mailComposeViewController.setSubject("Message From \(name)")
        
        mailComposeViewController.setMessageBody(message, isHTML: false)
        
        mailComposeViewController.setToRecipients(["180915an@gmail.com"])
        
        mailComposeViewController.setCcRecipients([replyTo])
        
        return mailComposeViewController
        
    }
    
    func updateUIViewController(_ iuViewController: MFMailComposeViewController, context: Context){}
    
    class Coordinator : NSObject ,MFMailComposeViewControllerDelegate{
        let parent : MailView
        
        init(_ parent: MailView) {
            self.parent = parent
        }
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.presentation.wrappedValue.dismiss()
        }
    }
}




struct ContactForm_Previews: PreviewProvider {
    static var previews: some View {
        ContactForm()
    }
}


// https://github.com/Anastasiia/emailjs-sdk-swift
