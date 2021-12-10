//
//  chatDelat&editeVC.swift
//  My Project (Chating)
//
//  Created by Najd Alquarishi on 08/12/2021.
//

import UIKit

class chatDelat_editeVC: UIViewController {
    
    var isCreation = true
    var editedChat: Chatss?
    var editedChatIndex: Int?
    var chat: Chatss!
    var indxe: Int!
    
//MARK:
    
    @IBOutlet weak var editButon: UIButton!
    @IBOutlet weak var deleteButon: UIButton!
    @IBOutlet weak var ChingTitelTextField: UITextField!
    @IBOutlet weak var chatImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if let chat = editedChat{
            ChingTitelTextField.text = chat.title
            chatImageView.image = chat.image
            chatImageView.layer.cornerRadius = chatImageView.frame.width/2
    }
    }
    
    @IBAction func changeButonAct(_ sender: Any) {
        
        let imagePic = UIImagePickerController()
        imagePic.delegate = self
        imagePic.allowsEditing = true
        present(imagePic, animated: true, completion: nil)
        
    }
    @IBAction func editButonAct(_ sender: Any) {
        let chatNew = Chatss(title: ChingTitelTextField.text! , image: chatImageView.image)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CurrentChatEdited") , object: nil,userInfo: ["editedChat":chatNew,"editedChatIndex": editedChatIndex! ])
        
        let alert = UIAlertController(title: "تمت التعديل ", message: "تم تعديل المهمة بنجاح", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "تم", style: .default) { _ in self.navigationController?.popViewController(animated: true)
            self.ChingTitelTextField.text = ""
            self.chatImageView.image = nil
        }
        alert.addAction(closeAction)
        present(alert, animated: true, completion: {})
    }
    
   
    
    @IBAction func deleteButonAct(_ sender: Any) {
        
        let confirmAlert = UIAlertController(title: "تنبيه", message: "هل أنت متأكد من رغبتك في  إتمام عملية الحذف ", preferredStyle: .alert)
        
        let confirAction = UIAlertAction(title: "تأكيد", style: .destructive) { alert in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ChatDelet"), object: nil , userInfo: ["deleteChatIndxe" :  self.editedChatIndex! ])
            
            let alert = UIAlertController(title: "تم", message: "تم حذف المهمه بنجاح", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "تم", style: .default) { alert in
                self.navigationController.self?.popToRootViewController(animated: true)
            }
            alert.addAction(closeAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        confirmAlert.addAction(confirAction)
        
        let cancelAction = UIAlertAction(title: "تراجع", style: .cancel, handler: nil)
        
        confirmAlert.addAction(cancelAction)
        present(confirmAlert, animated: true, completion: nil)
        
    }

}

extension chatDelat_editeVC:UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image  = info[.editedImage]
        as! UIImage
        dismiss(animated: true, completion: nil)
        chatImageView.image = image
        
        
    }
}
