//
//  DatePeristenceManger.swift
//  World News
//
//  Created by Macbook on 07/07/2024.
//

import Foundation
import UIKit
import CoreData
class DataPersistenceManger {
    
    
   static func saveNew(model : Results , completionHandler : @escaping (Result<Void , Error>)->Void){

        guard let appdelegete = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let contex = appdelegete.persistentContainer.viewContext
        let news = NewsInfo(context: contex)
       news.title = model.title
       news.image_url = model.image_url
       news.link = model.link
       news.source_icon = model.source_icon
       news.pubDate = model.pubDate
       news.desc = model.description
      // news.creator = model.creator?[0]
       // news.des = model.description
      
    //   news.creator = model.creator
        do{
            try contex.save()
            
            completionHandler(.success(()))
            print("Saved ",news)
        }catch{
            print("FaildToSave")
        }
    }
    
    
    static func getSavedNews(completionHandler : @escaping(Result<[NewsInfo] , Error>)->Void){
        
        guard let appdelegete = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appdelegete.persistentContainer.viewContext
        
        let request : NSFetchRequest<NewsInfo>
        
        request = NewsInfo.fetchRequest()
        
        
        do {
            let news = try context.fetch(request)
            print(news)
            completionHandler(.success(news))
            
        }catch{
            completionHandler(.failure("error" as! Error))
        }
    }
    
    static func deleteNews(model : NewsInfo , completionHandler : @escaping (Result <Void , Error>)->Void){
        
        guard let appdelegete = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appdelegete.persistentContainer.viewContext
        context.delete(model)
        do{
            try context.save()
            completionHandler(.success(()))
        }catch{
            completionHandler(.failure(() as! Error))
        }
    }
}
