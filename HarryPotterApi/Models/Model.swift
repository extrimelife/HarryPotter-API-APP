//
//  Model.swift
//  HarryPotterApi
//
//  Created by roman Khilchenko on 24.09.2022.
//

import Foundation

struct Character: Decodable {
    
    let name: String
    let dateOfBirth: String
    let house: String
    let actor: String
    let image: String
    var commonInfo: String {
        """
        House:  \(house).
        Actor:  \(actor).
        Date of Birth:  \(dateOfBirth).
        """
    }
    
}
