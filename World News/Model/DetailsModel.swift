//
//  DetailsModel.swift
//  World News
//
//  Created by Macbook on 07/07/2024.
//

import Foundation

struct DetailsModel : Codable{
    let title : String?
    let link : String?
    let creator : [String]?
    let description : String?
    let pubDate : String?
    let image_url : String?
    let source_icon : String?

}
