//
//  EditeChatInf.swift
//  My Project (Chating)
//
//  Created by Najd Alquarishi on 05/12/2021.
//

import UIKit

class EditeChatInf: UIViewController {

    var chat: Chatss!
    var edit: Chatss!
    var indxe: Int!
    @IBOutlet weak var editeNumberLabel: UILabel!
    @IBOutlet weak var editeImageView: UIImageView!
    @IBOutlet weak var editeTitilLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(CurrentChatEdited) , name: NSNotification.Name(rawValue: "CurrentChatEdited"), object: nil)
    
    }
    
    @objc func CurrentChatEdited(notification: Notification){
        
        if let chat = notification.userInfo?["editedChat"] as? Chatss{
            
            self.chat = chat
            setupUI()
    }}
    
    func setupUI() {
        
        editeTitilLabel.text = chat.title
       // editeTitilLabel.text = edit.title
        editeNumberLabel.text = chat.mobileNum
        
        editeImageView.image = chat.image
      //  editeImageView.image = edit.image
        editeImageView.layer.cornerRadius = editeImageView.frame.width/2
        
    }
    
    @IBAction func editeChatBotumeCliced(_ sender: Any) {
    if let viweController =
    storyboard?.instantiateViewController(withIdentifier: "chatDelat_editeVC") as? chatDelat_editeVC {
       viweController.editedChat = chat
       viweController.editedChatIndex = indxe
            
    navigationController?.pushViewController(viweController, animated: true)
                  
    }
    }



}
