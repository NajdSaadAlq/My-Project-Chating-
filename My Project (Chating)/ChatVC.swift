//
//  ChatVC.swift
//  My Project (Chating)
//
//  Created by Najd Alquarishi on 05/12/2021.
//

import UIKit
import CoreData

class ChatVC: UIViewController {
    
    var chatAarray:[Chatss] = [

    ]
    
    
    
    @IBOutlet weak var chatTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        
        self.chatAarray = getchats()
        
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
            storeChate(chat: myChat)
        }
    }
  
    @objc func CurrentChatEdited(notification: Notification){
        
        if let chat = notification.userInfo?["editedChat"] as? Chatss{
            if let indexE = notification.userInfo?["editedChatIndex"] as? Int{
                
                chatAarray[indexE] = chat
                chatTableView.reloadData()
               updateChat(chat: chat, index: indexE)
            }
        }

    }
    
    @objc func ChatDelet(notification: Notification){
        
        if let indexD = notification.userInfo?["deleteChatIndxe"] as? Int{
            
            chatAarray.remove(at: indexD)
            chatTableView.reloadData()
            deleateChat(index: indexD)

    }
    }
    
    //MARK: Data Core
    
    //MARK: storeg the data
    func storeChate(chat:Chatss){
        //adintfiy app delegte
        guard let appdelegte = UIApplication.shared.delegate as? AppDelegate else {return}
        // grab the data core to drag the entity انادي قاعدة البيانات واقدر اوصل للقوالب حقتي
        let manageContext = appdelegte.persistentContainer.viewContext
        // crete object of entity
        guard let chatEntity = NSEntityDescription.entity(forEntityName: "Chat", in: manageContext) else { return  }
        
        let chatObject = NSManagedObject.init(entity: chatEntity, insertInto: manageContext)
        chatObject.setValue(chat.title, forKey: "title")
        //number
        chatObject.setValue(chat.mobileNum, forKey: "mobileNum")
      //  chatObject.setValue(chat.detailsG, forKey: "detailsG")
        chatObject.setValue(chat.detailsG, forKey: "detailsG")
        if let image = chat.image {
                        //image.pngData()   the two shosess
            let imageData = image.jpegData(compressionQuality: 1)
            chatObject.setValue(imageData, forKey: "image")}

        
        do{
            try manageContext.save()
            print("========== success =============")

        }catch{
            print("========== error =============")
        }
    }
    
    //MARK: Uppdte the data storg
    func updateChat(chat:Chatss,index:Int){
        guard let appdelegte = UIApplication.shared.delegate as? AppDelegate else {return}
         let context = appdelegte.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Chat")
        
        do{
        let result = try context.fetch(fetchRequest) as!  [NSManagedObject]
            
            result[index].setValue(chat.title, forKey: "title")
            result[index].setValue(chat.mobileNum, forKey: "mobileNum")
            
            if let image = chat.image {
                            //image.pngData()   the two shosess
                let imageData = image.jpegData(compressionQuality: 1)
                result[index].setValue(imageData, forKey: "image")}
            
            try context.save()
            
        }catch{
            print("========== error =============")
        }}
       
        //MARK: Deleat the data storg
        func deleateChat(index:Int){
            guard let appdelegte = UIApplication.shared.delegate as? AppDelegate else {return}
             let context = appdelegte.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Chat")
            do{
            let result = try context.fetch(fetchRequest) as!  [NSManagedObject]
               
                let chatDelet = result[index]
                context.delete(chatDelet)
                try context.save()
                
            }catch{
                print("========== error =============")
           }
        
    }
    
    //MARK: get the storg data
func getchats() -> [Chatss] {
    var chats: [Chatss] = []
    guard let appdelegte = UIApplication.shared.delegate as? AppDelegate else {return []}
    let context = appdelegte.persistentContainer.viewContext
//        //دخول وقراءه من قاعدة البيانات
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Chat")
        do{
        let result = try context.fetch(fetchRequest) as!  [NSManagedObject]
        for manageChat in result {
            let title = manageChat.value(forKey: "title") as! String
            let detailsG = manageChat.value(forKey: "detailsG") as? String
            let mobileNum = manageChat.value(forKey: "mobileNum") as! String
            var transformValues :UIImage? = nil
            if let imgFromContext = manageChat.value(forKey: "image") as? Data {
                transformValues = UIImage(data: imgFromContext)
            }
            let chat = Chatss(title: title, mobileNum: mobileNum , image: transformValues, detailsG: detailsG )
            chats.append(chat)
        }
            print("========== success =============")

       }catch{
           print("========== error =============")
      }
       return chats
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


