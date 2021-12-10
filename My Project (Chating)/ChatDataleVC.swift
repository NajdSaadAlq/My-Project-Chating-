//
//  ChatDataleVC.swift
//  My Project (Chating)
//
//  Created by Najd Alquarishi on 06/12/2021.
//

import UIKit

class ChatDataleVC: UIViewController{
    
    var chat: Chatss!
    var inChat: InChat!
    var edit: Chatss!
    var indxe: Int!
    
    @IBOutlet weak var cellLabel3: UILabel!
    @IBOutlet weak var cellLabel2: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImageView3: UIImageView!
    @IBOutlet weak var cellImageView2: UIImageView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var chatTitelButton: UIButton!
    @IBOutlet weak var bacgroindImageView: UIImageView!
    

    
    
     override func viewDidLoad()
{
         super.viewDidLoad()
         setupUI()
    
    NotificationCenter.default.addObserver(self, selector: #selector(CurrentChatEdited) , name: NSNotification.Name(rawValue: "CurrentChatEdited"), object: nil)
         
       
}

    @objc func CurrentChatEdited(notification: Notification){
        
        if let chat = notification.userInfo?["editedChat"] as? Chatss{
            
            self.chat = chat
            setupUI()
            
    }}

    
    @IBAction func chatTitalAct(_ sender: Any) {
        
        let vcc=storyboard?.instantiateViewController(withIdentifier:"EditeChatInf") as? EditeChatInf
        if let viewcontroller = vcc {//        go to therd page3 informachine for the chat with (edit & indxe)
        viewcontroller.chat = chat
        viewcontroller.indxe = indxe
        navigationController?.pushViewController(viewcontroller, animated: true)
        
        }
          
          
 }
        
    
    

func setupUI()
{
    chatTitelButton.setTitle(chat.title, for: .normal)
    chatTitelButton.titleLabel?.text = chat.title
    cellLabel3.text = chat.detailsG
    cellImageView.image = chat.image
    cellImageView2.image = chat.image
    cellImageView3.image = UIImage(named: "person")
    
    cellImageView.layer.cornerRadius = cellImageView.frame.width/2
    cellImageView2.layer.cornerRadius = cellImageView2.frame.width/2
    cellImageView3.layer.cornerRadius = cellImageView3.frame.width/2
    
    
}
    
    
}
