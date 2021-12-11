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
    
    @IBOutlet weak var chatNumberTextField: UITextField!
    @IBOutlet weak var editButon: UIButton!
    @IBOutlet weak var deleteButon: UIButton!
    @IBOutlet weak var ChingTitelTextField: UITextField!
    @IBOutlet weak var chatImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if let chat = editedChat{
            ChingTitelTextField.text = chat.title
            chatNumberTextField.text = chat.mobileNum
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
        
        let alert = MyAlertViewController(
            title: "تم التعديل ",
            message: "لقد تم تعديل البيانات",
            imageName: ("Image-6")  )
        
        let chatNew = Chatss(title: ChingTitelTextField.text!, mobileNum: chatNumberTextField.text! , image: chatImageView.image)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CurrentChatEdited") , object: nil,userInfo: ["editedChat":chatNew,"editedChatIndex": editedChatIndex! ])
        
        
        
        
        alert.addAction(title: "تم", style: .default) { _ in self.navigationController?.popViewController(animated: true)
            self.ChingTitelTextField.text = ""
            self.chatNumberTextField.text = ""
            self.chatImageView.image = nil
        
        }
        present(alert, animated: true, completion: {})
    }
    
   
    
    @IBAction func deleteButonAct(_ sender: Any) {
        
        let alert = MyAlertViewController(
            title: "تنبيه",
            message: "هل أنت متأكد من رغبتك في  حذف جهة الاتصال",
            imageName: ("Image-3")  )

        alert.addAction(title: "تأكيد", style: .destructive){ alert in
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ChatDelet"), object: nil , userInfo: ["deleteChatIndxe" :  self.editedChatIndex! ])
            
            let alert = MyAlertViewController(
                title: "تم",
                message: "تم حذف جهة الاتصال",
                imageName: ("Image-6")  )
            alert.addAction(title: "تم", style: .default) { alert in
            self.navigationController.self?.popToRootViewController(animated: true)
        }
         
            self.present(alert, animated: true, completion: nil)
        }
        
        alert.addAction(title: "تراجع", style: .cancel)

        present(alert, animated: true, completion: nil)
        
        
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
