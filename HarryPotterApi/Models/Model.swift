//
//  Model.swift
//  HarryPotterApi
//
//  Created by roman Khilchenko on 24.09.2022.
//

import Foundation

struct Character: Decodable {
    
    let character: String?
    let hogwartsStudent: Bool?
    let hogwartsHouse: String?
    let interpretedBy: String?
    let child: [String]?
    let image: String?
    
}


