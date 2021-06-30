//
//  Episodes.swift
//  iOSChallenge
//
//  Created by Samaniego Villarroel Stephany Katherine on 6/28/21.
//

import Foundation


struct Episodes : Decodable {
    let id : Int?
    let name : String?
    let season : Int?
    let number : Int?
    
    
    let genres : [String?]
    let schedule : Schedule?
    let image : Image?
    let summary : String?
    
}

struct Image : Decodable{
    let medium : String?
    let original : String?
}

struct Schedule : Decodable{
    let time : String?
    let days : [String?]
}
