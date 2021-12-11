//
//  ChatStorage.swift
//  My Project (Chating)
//
//  Created by Najd Alquarishi on 11/12/2021.
//

import UIKit
import CoreData

class ChatStorage{
    
    //MARK: Data Core
    
    //MARK: storeg the data
   static func storeChate(chat:Chatss){
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
  static  func updateChat(chat:Chatss,index:Int){
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
    static    func deleateChat(index:Int){
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
   static   func getchats() -> [Chatss] {
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



    

