import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentation
    
    var name : String
    var replyTo : String
    var message : String
    
    static func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController{
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = context.coordinator
        mailComposeViewController.setSubject("Message From \(name)")
        mailComposeViewController.setMessageBody(message, isHTML: false)
        mailComposeViewController.setToRecipients(["180915an@gmail.com"])
        mailComposeViewController.setCcRecipients([replyTo])
        
        return mailComposeViewController
        
    }
    
    func updateUIViewController(_ iuViewController: MFMailComposeViewController, context: Context) {
    }
    
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
