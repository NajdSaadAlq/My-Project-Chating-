//
//  ChatVC.swift
//  My Project (Chating)
//
//  Created by Najd Alquarishi on 05/12/2021.
//

import UIKit


class ChatVC: UIViewController{
   
    var chatAarray:[Chatss] = [

    ]
    
    
    
    @IBOutlet weak var chatTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        
        self.chatAarray = ChatStorage.getchats()
        
        super.viewDidLoad()
        
        //New Chat Notification
        NotificationCenter.default.addObserver(self, selector: #selector(newChatAdded), name: NSNotification.Name(rawValue: "NewChhatAdded"), object: nil)
        
        //Edit Chat Notification
        NotificationCenter.default.addObserver(self, selector: #selector(CurrentChatEdited) , name: NSNotification.Name(rawValue: "CurrentChatEdited"), object: nil)
        
        //Delet Chat Notification
        NotificationCenter.default.addObserver(self, selector: #selector(ChatDelet) , name: NSNotification.Name(rawValue: "ChatDelet"), object: nil)
      
        chatTableView.dataSource = self
        chatTableView.delegate = self
    }
    
    @objc func newChatAdded(notification: Notification){
       
        if let myChat = notification.userInfo?["addedChat"] as? Chatss{
            chatAarray.append(myChat)
            chatTableView.reloadData()
            ChatStorage.storeChate(chat: myChat)
        }
    }
  
    @objc func CurrentChatEdited(notification: Notification){
        
        if let chat = notification.userInfo?["editedChat"] as? Chatss{
            if let indexE = notification.userInfo?["editedChatIndex"] as? Int{
                
                chatAarray[indexE] = chat
                chatTableView.reloadData()
                ChatStorage.updateChat(chat: chat, index: indexE)
            }
        }

    }
    
    @objc func ChatDelet(notification: Notification){
        
        if let indexD = notification.userInfo?["deleteChatIndxe"] as? Int{
            
            chatAarray.remove(at: indexD)
            chatTableView.reloadData()
            ChatStorage.deleateChat(index: indexD)

    }
    }
}
 


//MARK: contine of code for the clas ChatVC

extension ChatVC: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chatAarray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        

        cell.chatTitleLabel.text = chatAarray[indexPath.row].title
        cell.chatNumberLabel.text = chatAarray[indexPath.row].mobileNum
        cell.chatReactionTitleLabel.text = chatAarray[indexPath.row].detailsG

    
        if chatAarray[indexPath.row].image != nil{
            cell.chatImageView.image = chatAarray[indexPath.row].image
        }else{
            cell.chatImageView.image = #imageLiteral(resourceName: "nilll")
        }
    
        cell.chatImageView.layer.cornerRadius = cell.chatImageView.frame.width/2
        
        
        return cell
    
    
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    tableView.deselectRow(at: indexPath, animated: true) //اشيل التضليل الاختيار
       



        let chat = chatAarray[indexPath.row]

        let vc1 = storyboard?.instantiateViewController(withIdentifier: "ChatDataleVC")as? ChatDataleVC
        if let viewcontroller = vc1 {//go to secand page2 for the chat hi silfe with (chat)
        viewcontroller.chat = chat
        viewcontroller.indxe = indexPath.row
            
        navigationController?.pushViewController(viewcontroller, animated: true)
        chatTableView.reloadData()
            
        }
        let vc2=storyboard?.instantiateViewController(withIdentifier:"EditeChatInf") as? EditeChatInf
        if let viewcontroller = vc2 {//        go to therd page3 informachine for the chat with (edit & indxe)
        viewcontroller.chat = chat
        viewcontroller.indxe = indexPath.row
        chatTableView.reloadData()
        }

        let vc3=storyboard?.instantiateViewController(withIdentifier:"chatDelat_editeVC") as? chatDelat_editeVC
        if let viewcontroller = vc3 {//        go to therd page4 informachine for the chat with (edit & indxe)
        viewcontroller.chat = chat
        viewcontroller.indxe = indexPath.row
        chatTableView.reloadData()
        }
    }
}


