//
//  APICaller.swift
//  World News
//
//  Created by Macbook on 06/07/2024.
//

import Foundation
import UIKit
import Alamofire

final class APICaller{
    struct Constant{
        static let API_Key = "pub_11529a6414f54929aafd7a4de17988c11201d"
        static var articalTitle : [String]!
    }
    static func getNews(completationHandler :@escaping( Result<[Results],Error>)->Void){
        
        guard let url = URL(string: "https://newsdata.io/api/1/news?apikey=\(APICaller.Constant.API_Key)")else{
            return
        }
        AF.request(url,method: .get).responseDecodable(of: NewsModel.self) { response in
            switch response.result{
            case .success(let News) :
                print(News)
                completationHandler(.success(News.results!))
            case .failure(let error):
               
                print(error)
                completationHandler(.failure(error))
            }
        }
    }
    
    static func getBreakingNews(completationHandler :@escaping( Result<[Results],Error>)->Void){
        
        guard let url = URL(string: "https://newsdata.io/api/1/latest?apikey=\(APICaller.Constant.API_Key)&q=pegasus&language=en")else{
            return
        }
        AF.request(url,method: .get).responseDecodable(of: NewsModel.self) { response in
            switch response.result{
            case .success(let News) :
                print(News)
                completationHandler(.success(News.results!))
            case .failure(let error):
               
                print(error)
                completationHandler(.failure(error))
            }
        }
    }
    static func getsearchNews(completationHandler :@escaping( Result<[Results],Error>)->Void){
        
        guard let url = URL(string: "https://newsdata.io/api/1/news?apikey=\(APICaller.Constant.API_Key)")else{
            return
        }
        AF.request(url,method: .get).responseDecodable(of: NewsModel.self) { response in
            switch response.result{
            case .success(let News) :
                print(News)
                completationHandler(.success(News.results!))
            case .failure(let error):
               
                print(error)
                completationHandler(.failure(error))
            }
        }
    }
    static func searchForNews(query : String , completionHandler : @escaping(Result<[Results],Error>)->Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)else{return}

        guard let url = URL(string: "https://newsdata.io/api/1/news?apikey=\(APICaller.Constant.API_Key)&q=\(query)")else{
            return
        }
        AF.request(url,method: .get).responseDecodable(of: NewsModel.self) { reponse  in
            switch reponse.result{
            case .success(let searchedNews):
                completionHandler(.success(searchedNews.results!))
                print("Searched News",searchedNews)
            case .failure(let error):
                print(error)
            }
        }
        
        
    }

    
}

