import SwiftUI
import UIKit

struct ReminderTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var onDateTap: () -> Void
    var onLocationTap: () -> Void
    var onHashtagTap: () -> Void
    var onFlagTap: () -> Void
    var onPhotoTap: () -> Void
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.delegate = context.coordinator
        
        // Configure text field appearance
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.font = .systemFont(ofSize: 17)
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        
        // Create the toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let calendarButton = UIBarButtonItem(
            image: UIImage(systemName: "calendar"),
            style: .plain,
            target: context.coordinator,
            action: #selector(Coordinator.addDate)
        )
        
        let locationButton = UIBarButtonItem(
            image: UIImage(systemName: "location"),
            style: .plain,
            target: context.coordinator,
            action: #selector(Coordinator.addLocation)
        )
        
        let hashtagButton = UIBarButtonItem(
            title: "#",
            style: .plain,
            target: context.coordinator,
            action: #selector(Coordinator.addHashtag)
        )
        
        let flagButton = UIBarButtonItem(
            image: UIImage(systemName: "flag"),
            style: .plain,
            target: context.coordinator,
            action: #selector(Coordinator.addFlag)
        )
        
        let photoButton = UIBarButtonItem(
            image: UIImage(systemName: "photo"),
            style: .plain,
            target: context.coordinator,
            action: #selector(Coordinator.addPhoto)
        )
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        toolbar.items = [
            calendarButton,
            flexibleSpace,
            locationButton,
            flexibleSpace,
            hashtagButton,
            flexibleSpace,
            flagButton,
            flexibleSpace,
            photoButton
        ]
        
        textField.inputAccessoryView = toolbar
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        // Only update text if it's different to avoid cursor position reset
        if uiView.text != text {
            let currentPosition = uiView.selectedTextRange
            uiView.text = text
            if let position = currentPosition {
                uiView.selectedTextRange = position
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: ReminderTextField
        
        init(_ parent: ReminderTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        @objc func addDate() {
            parent.onDateTap()
        }
        
        @objc func addLocation() {
            parent.onLocationTap()
        }
        
        @objc func addHashtag() {
            parent.onHashtagTap()
        }
        
        @objc func addFlag() {
            parent.onFlagTap()
        }
        
        @objc func addPhoto() {
            parent.onPhotoTap()
        }
    }
} 