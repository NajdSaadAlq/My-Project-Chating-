//
//  CreateChat.swift
//  My Project (Chating)
//
//  Created by Najd Alquarishi on 05/12/2021.
//

import UIKit

class CreateChat: UIViewController {
    
    var isCreation = true
    var editedChat: Chatss?
    var editedChatIndex: Int?
    var indxe: Int!
   
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var imageChat: UIImageView!
    @IBOutlet weak var detailsTextView: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var mineIxeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !isCreation{
//            mineIxeButton.setTitle("Edit", for: .normal)
//            navigationItem.title = "Edit Content"
            if let chat = editedChat{
                titleTextField.text = chat.title
                mobileTextField.text = chat.mobileNum
                detailsTextView.text = chat.detailsG
                imageChat.image = chat.image
           //     mobileTextField.text = chat.mobileNum
        }
        
        
        // Do any additional setup after loading the view.
    }
    }
    
    @IBAction func chooseImageButtonAct(_ sender: Any) {
        let imagePic = UIImagePickerController()
        imagePic.delegate = self
        imagePic.allowsEditing = true
        present(imagePic, animated: true, completion: nil)
        
    }
    @IBAction func addBarButtonClicked(_ sender: Any) {
        
        let chatNew = Chatss(title: titleTextField.text!, mobileNum: mobileTextField.text! , image: imageChat.image, detailsG: detailsTextView.text!)
        
        NotificationCenter.default.post(name: Notification.Name("NewChhatAdded"), object: nil,userInfo: ["addedChat":chatNew])
            ///
           
            let alert = UIAlertController(title: "تمت الاضافة", message: "تم إضافة جهة الاتصال ", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "تم", style: .default) { _ in self.tabBarController?.selectedIndex = 0
                self.titleTextField.text = ""
                self.mobileTextField.text = ""
                self.detailsTextView.text = ""
                self.imageChat.image = nil
            }
            alert.addAction(closeAction)
            present(alert, animated: true, completion: {})
            
        }

        
}
    
extension CreateChat:UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image  = info[.editedImage]
        as! UIImage
        dismiss(animated: true, completion: nil)
        imageChat.image = image
        
        
    }
}
