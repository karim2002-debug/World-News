//
//  Model.swift
//  World News
//
//  Created by Macbook on 06/07/2024.
//

import Foundation

struct NewsModel : Codable{
    let status : String?
    let totalResults : Int?
    let results : [Results]?
}
struct Results : Codable{
   // let article_id : String?
     let title : String?
     let link : String?
     let creator : [String]?
    let description : String?
    let pubDate : String?
    let image_url : String?
    let source_icon : String?
}
